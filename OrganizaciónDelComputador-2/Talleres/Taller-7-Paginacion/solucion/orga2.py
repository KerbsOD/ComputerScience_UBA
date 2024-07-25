from dataclasses import dataclass
import os
import gdb

def load_descriptor_table(name, identifier):
    # Cargo todos los registros según qemu
    qemu_registers = gdb.execute('monitor info registers', to_string=True)
    # Busco al gdt
    descriptors = [reg for reg in qemu_registers.split('\n') if reg.startswith(f"{identifier}=")]
    # Debería haber uno sólo, me quedo con ese
    assert len(descriptors) == 1, f"Detectamos más de un {name}"
    descriptor_text = descriptors[0]

    # Parseo el texto de qemu
    #   Formato esperado:
    #   GDT=     00005020 00000117
    #              ó
    #   IDT=     000051a0 000007f7
    #   <Ident>    <Base>   <Size>
    (base_text, size_text) = descriptor_text.split()[1:]
    base = int(base_text, 16)
    size = int(size_text, 16) + 1 # +1 porque en realidad es el máximo offset
    assert size % 8 == 0, f"La {identifier} no tiene una cantidad entera de entradas"

    return base, size

def load_tr():
    # Cargo todos los registros según qemu
    qemu_registers = gdb.execute('monitor info registers', to_string=True)
    # Busco al tr:
    descriptors = [reg for reg in qemu_registers.split('\n') if reg.startswith("TR")]
    # Debería haber uno sólo, me quedo con ese
    assert len(descriptors) == 1, f"Detectamos más de un tr"
    tr_text  = descriptors[0]

    # Parseo el texto de qemu
    #   Formato esperado:
    #   TR =0000 00000000 0000ffff 00008b00 DPL=0 TSS32-busy
    #   <Selector>    <Base>   <Size>
    (sel_text, base_text, segment_limit_text) = tr_text.split()[1:4]
    selector_num = sel_text[1:]
    selector = int(selector_num, 16)
    base = int(base_text, 16)
    limit  = int(segment_limit_text, 16) + 1 # +1 porque en realidad es el máximo offset

    return selector, base, limit

def format_address(addr):
    return gdb.execute(f'output/a 0x{addr:X}', to_string=True)

def print_table(rows):
    columns = {}

    for row in rows:
        for idx, column in enumerate(row):
            width = len(column)
            if idx in columns:
                columns[idx] = max(columns[idx], width)
            else:
                columns[idx] = width

    for row in rows:
        for idx, column in enumerate(row):
            print(column.ljust(columns[idx] + 1), end='')
        print()

def print_descriptor_table(register_name, table_name, descriptor, formatter, skip_not_present=True):
    base, size = descriptor
    entry_count = size // 8

    inferior = gdb.selected_inferior()

    print(register_name, "points to", format_address(base), "containing", entry_count, "entries:")

    rows = []

    for i in range(entry_count):
        addr = base + i * 8
        entry_bytes = inferior.read_memory(addr, 8)
        entry_p = bool(int.from_bytes(entry_bytes[5], 'little') & 0x80)

        if skip_not_present and not entry_p:
            continue

        row = [str(column) for column in formatter(entry_bytes)]
        row.insert(0, f'{table_name}[{i}] =')
        rows.append(row)

    print_table(rows)

def print_descriptor_entry(table_name, gdt, index, formatter):
    base, size = gdt
    entry_count = size // 8
    assert 0 <= index <= entry_count, f"{table_name.upper()} index outside valid bounds"

    inferior = gdb.selected_inferior()
    addr = base + index * 8
    entry_bytes = inferior.read_memory(addr, 8)
    row = formatter(entry_bytes)
    print(f'{table_name}[{index}] =', ' '.join(row))

def is_gdt_entry_of_type_tss(entry_bytes):
    entry = [int.from_bytes(b, 'little') for b in entry_bytes]
    entry_type = entry[5] & 0x0F
    return (entry_type == 9 or entry_type == 11)

def print_tss(index):
    inferior = gdb.selected_inferior()
    current_tss_selector, current_tss_base, _ = load_tr()

    # si index == -1 mostramos la tss del TR
    if index == -1:
        tss_base = current_tss_base
        print(f'TSS for TR ({current_tss_selector:#x})')
    # sino, mostramos la i-esima cargada en la gdt
    else:
        base, size = load_descriptor_table('gdtr', 'GDT')
        addr = base + index * 8
        gdt_entry_bytes = inferior.read_memory(addr, 8)

        # primero chequeamos que sea un indice valido, osea que apunte a una TSS
        if not is_gdt_entry_of_type_tss(gdt_entry_bytes):
            print(f"El índice {index} no apunta a una TSS")
            return

        entry = [int.from_bytes(b, 'little') for b in gdt_entry_bytes]
        tss_base = entry[7] << 24 | entry[4] << 16 | entry[3] << 8 | entry[2]

        print(f'TSS for gdt[{index}]' + (' (currently loaded in TR)' if current_tss_selector >> 3 == index else ''))

    tss_bytes = inferior.read_memory(tss_base, 104)
    print(f'base={format_address(tss_base)}')
    print_tss_entry(tss_bytes)

# When the S (descriptor type) flag in a segment descriptor is set, the descriptor is for either a code or a data segment.
# Entonces usamos esta tablita:
gdt_entry_types_code_or_data = [
    'Read-Only',
    'Read-Only, accessed',
    'Read-Write',
    'Read-Write, accessed',
    'Read-Only, expand-down',
    'Read-Only, expand-down, accessed',
    'Read-Write, expand-down',
    'Read-Write, expand-down, accessed',
    'Execute-Only',
    'Execute-Only, accessed',
    'Execute/Read',
    'Execute/Read, accessed',
    'Execute-Only, conforming',
    'Execute-Only, conforming, accessed',
    'Execute/Read, conforming',
    'Execute/Read, conforming, accessed',
]

# En cambio si S es 0, the descriptor type is a system descriptor. Entonces usamos esta tablita:
gdt_entry_types_system = [
    'Reserved',
    '16-bit TSS (Available)',
    'LDT',
    '6-bit TSS (Busy)',
    '16-bit Call Gate',
    'Task Gate',
    '16-bit Interrupt Gate',
    '16-bit Trap Gate',
    'Reserved',
    '32-bit TSS (Available)',
    'Reserved',
    '32-bit TSS (Busy)',
    '32-bit Call Gate',
    'Reserved',
    '32-bit Interrupt Gate',
    '32-bit Trap Gate',
]

def format_gdt_entry(entry_bytes):
        entry = [int.from_bytes(b, 'little') for b in entry_bytes]                          # entry son 8 bytes
        entry_base = entry[7] << 24 | entry[4] << 16 | entry[3] << 8 | entry[2]
        entry_limit = (entry[6] & 0x0F) << 16 | entry[1] << 8 | entry[0]
        entry_type = entry[5] & 0x0F
        entry_s = bool(entry[5] & 0x10)
        entry_dpl = (entry[5] & 0x60) >> 5
        entry_p = bool(entry[5] & 0x80)
        entry_a = bool(entry[6] & 0x10)
        entry_l = bool(entry[6] & 0x20)
        entry_db = bool(entry[6] & 0x40)
        entry_g = bool(entry[6] & 0x80)

        return [f'Base: {format_address(entry_base)},',
                (f'Limit: {entry_limit:#x},' if entry_s else f'Length: {entry_limit:#x},'),
                (('page granularity,' if entry_g else 'byte granularity,') if entry_s else ''),  # en un TSS Descriptor G
                (f'D/B: {int(entry_db)},' if entry_s else ''),              # en un TSS Descriptor el bit correspondiente a D/B esta siempre en 0
                f'L: {int(entry_l)},',
                ('available bit set,' if entry_a else 'available bit clear,'),
                ('present,' if entry_p else 'not present,'),
                f'DPL: {entry_dpl},',
                ('Code/Data Segment,' if entry_s else 'System Segment,'),
                f'Type: {gdt_entry_types_code_or_data[entry_type]}' if entry_s else f'Type: {gdt_entry_types_system[entry_type]}']

# TSS
"""
Comando info tss en Bochs muestra:
tr:s=0x68, base=0x000079c0, valid=1
ss:esp(0): 0x0018:0x00104000
ss:esp(1): 0x0000:0x00000000
ss:esp(2): 0x0000:0x00000000
cr3: 0x00100000
eip: 0x08000000
eflags: 0x00000200
cs: 0x0013 ds: 0x0023 ss: 0x0023
es: 0x0023 fs: 0x0023 gs: 0x0023
eax: 0x00000000  ebx: 0x00000000  ecx: 0x00000000  edx: 0x00000000
esi: 0x00000000  edi: 0x00000000  ebp: 0x08003000  esp: 0x08003000
ldt: 0x0000
i/o map: 0x0000
"""
def format_address(addr):
    return gdb.execute(f'output/a 0x{addr:X}', to_string=True)

def print_tss_entry(entry_bytes):
    def u32(offset):
        return int.from_bytes(entry_bytes[offset:offset+4], 'little')

    def u16(offset):
        return int.from_bytes(entry_bytes[offset:offset+2], 'little')

    task_link = u16(  0)
    esp0      = u32(  4)
    ss0       = u16(  8)
    esp1      = u32( 12)
    ss1       = u16( 16)
    esp2      = u32( 20)
    ss2       = u16( 24)
    cr3       = u32( 28)
    eip       = u32( 32)
    eflags    = u32( 36)
    eax       = u32( 40)
    ecx       = u32( 44)
    edx       = u32( 48)
    ebx       = u32( 52)
    esp       = u32( 56)
    ebp       = u32( 60)
    esi       = u32( 64)
    edi       = u32( 68)
    es        = u16( 72)
    cs        = u16( 76)
    ss        = u16( 80)
    ds        = u16( 84)
    fs        = u16( 88)
    gs        = u16( 92)
    ldt       = u16( 96)
    io_map    = u16(102)

    regs = [(ds, "ds"),
            (es, "es"),
            (fs, "fs"),
            (cs, "cs"),
            (ss, "ss"),
            (gs, "gs"),
            (eax, "eax"),
            (ebx, "ebx"),
            (ecx, "ecx"),
            (edx, "edx"),
            (esi, "esi"),
            (edi, "edi"),
            (ebp, "ebp"),
            (esp, "esp")]

    print(f'ss:esp(0): {ss0:#x}:{format_address(esp0)}')
    print(f'ss:esp(1): {ss1:#x}:{format_address(esp1)}')
    print(f'ss:esp(2): {ss2:#x}:{format_address(esp2)}')
    print(f'cr3: {cr3:#x}')
    print(f'eip: {format_address(eip)}')
    print(f'eflags: {eflags:#x}')
    print_tss_regs(regs)

def print_tss_regs(all_regs):
    formatted_regs = [(name, format_address(reg)) for reg, name in all_regs]

    rows = []
    idx = 0
    while idx < len(formatted_regs):
        row = ['|']
        while idx < len(formatted_regs):
            name, value = formatted_regs[idx]
            row += (name, ':', value, '|')
            idx += 1

            if idx % 3 == 0:
                break
        rows.append(row)

    print_table(rows)

# IDT
idt_entry_types = {
    0b00101: 'Task Gate',
    0b00110: 'Interrupt Gate (16 bits)',
    0b01110: 'Interrupt Gate (32 bits)',
    0b01111: 'Trap Gate (16 bits)',
    0b11111: 'Trap Gate (32 bits)',
}

def format_idt_entry(entry_bytes):
        entry = [int.from_bytes(b, 'little') for b in entry_bytes]
        entry_offset = entry[7] << 24 | entry[6] << 16 | entry[1] << 8 | entry[0]
        entry_segsel = entry[3] << 8 | entry[2]
        entry_p = bool(entry[5] & 0x80)
        entry_dpl = (entry[5] & 0x60) >> 5
        entry_type = entry[5] & 0x1F

        segsel_idx = entry_segsel >> 3
        segsel_rpl = (entry_segsel & 0x06) >> 1
        segsel_ti = bool(entry_segsel & 0x01)
        segsel = f'{"ldt" if segsel_ti else "gdt"}[{segsel_idx}] (RPL={segsel_rpl})'

        return [f'Offset: {format_address(entry_offset)},',
                f'Segment Selector: {segsel},',
                ('present,' if entry_p else 'not present,'),
                f'DPL: {entry_dpl},',
                f'Type: {idt_entry_types.get(entry_type, f"Invalid Type (entry_type)")}']

class KernelCommand(gdb.Command):
    "Performs various kernel-related operations"
    def __init__(self):
        super().__init__('kernel', gdb.COMMAND_USER, gdb.COMPLETE_COMMAND, True)

    def invoke(self, argument, from_tty):
        print('kernel reload -- Reloads the currently loaded kernel')

class KernelReloadCommand(gdb.Command):
    "Reloads the currently loaded kernel"
    def __init__(self):
        super().__init__('kernel reload', gdb.COMMAND_USER, gdb.COMPLETE_NONE, False)

    def invoke(self, argument, from_tty):
        diskette = os.getcwd() + '/diskette.img'
        elf = 'kernel.bin.elf'
        gdb.execute('make')
        gdb.execute(f'file {elf}')
        gdb.execute('directory')
        gdb.execute(f'monitor change floppy0 {diskette} raw')
        gdb.execute('monitor system_reset')

"""
Comando info tss en Bochs muestra:
tr:s=0x68, base=0x000079c0, valid=1
ss:esp(0): 0x0018:0x00104000
ss:esp(1): 0x0000:0x00000000
ss:esp(2): 0x0000:0x00000000
cr3: 0x00100000
eip: 0x08000000
eflags: 0x00000200
cs: 0x0013 ds: 0x0023 ss: 0x0023
es: 0x0023 fs: 0x0023 gs: 0x0023
eax: 0x00000000  ebx: 0x00000000  ecx: 0x00000000  edx: 0x00000000
esi: 0x00000000  edi: 0x00000000  ebp: 0x08003000  esp: 0x08003000
ldt: 0x0000
i/o map: 0x0000
"""
class InfoTSSCommand(gdb.Command):
    """Shows the currently loaded TSS
    info tss -- Show TSS currently loaded in the Task Register
    info tss [idx] -- Show the i-th TSS"""
    def __init__(self):
        super().__init__('info tss', gdb.COMMAND_STATUS, gdb.COMPLETE_NONE, False)

    def invoke(self, argument, from_tty):
        if argument == '':
            print_tss(-1)
        else:
            index = gdb.parse_and_eval(argument)
            print_tss(index)

class InfoGDTCommand(gdb.Command):
    """Shows the currently loaded GDT
  info gdt -- Show descriptors present
  info gdt all -- Show all descriptors
  info gdt [idx] -- Show the i-th descriptor"""
    def __init__(self):
        super().__init__('info gdt', gdb.COMMAND_STATUS, gdb.COMPLETE_NONE, False)

    def invoke(self, argument, from_tty):
        gdtr = load_descriptor_table('gdtr', 'GDT')

        if argument == '':
            print_descriptor_table('GDTR', 'gdt', gdtr, format_gdt_entry)
        elif argument == 'all':
            print_descriptor_table('GDTR', 'gdt', gdtr, format_gdt_entry, False)
        else:
            index = gdb.parse_and_eval(argument)
            print_descriptor_entry('gdt', gdtr, index, format_gdt_entry)

class InfoIDTCommand(gdb.Command):
    """Shows the currently loaded IDT
  info idt -- Show descriptors present
  info idt all -- Show all descriptors
  info idt [idx] -- Show the i-th descriptor"""
    def __init__(self):
        super().__init__('info idt', gdb.COMMAND_STATUS, gdb.COMPLETE_NONE, False)

    def invoke(self, argument, from_tty):
        idtr = load_descriptor_table('idtr', 'IDT')

        if argument == '':
            print_descriptor_table('IDTR', 'idt', idtr, format_idt_entry)
        elif argument == 'all':
            print_descriptor_table('IDTR', 'idt', idtr, format_idt_entry, False)
        else:
            index = gdb.parse_and_eval(argument)
            print_descriptor_entry('idt', idtr, index, format_idt_entry)

KernelCommand()
KernelReloadCommand()
InfoGDTCommand()
InfoIDTCommand()
InfoTSSCommand()

class GDTPrinter:
    def __init__(self, val):
        self.val = val

    def children(self):
        void_star = gdb.lookup_type('void').pointer()
        u32 = gdb.lookup_type('unsigned int')

        limit = self.val['limit_19_16'].cast(u32) << 16 | self.val['limit_15_0'].cast(u32)
        yield 'limit', limit.cast(u32)
        base = self.val['base_31_24'].cast(u32) << 24 | self.val['base_23_16'].cast(u32) << 16 | self.val['base_15_0'].cast(u32)
        yield 'base', base.cast(void_star)

        yield 'type', self.val['type'].cast(u32)
        yield 's',    self.val['s'].cast(u32)
        yield 'dpl',  self.val['dpl'].cast(u32)
        yield 'p',    self.val['p'].cast(u32)
        yield 'avl',  self.val['avl'].cast(u32)
        yield 'l',    self.val['l'].cast(u32)
        yield 'db',   self.val['db'].cast(u32)
        yield 'g',    self.val['g'].cast(u32)

class IDTPrinter:
    def __init__(self, val):
        self.val = val

    def children(self):
        void_star = gdb.lookup_type('void').pointer()
        u32 = gdb.lookup_type('unsigned int')

        offset = self.val['offset_31_16'].cast(u32) << 16 | self.val['offset_15_0'].cast(u32)
        yield 'offset', offset.cast(void_star)

        yield 'segsel',  self.val['segsel'].cast(u32)
        yield 'type',    self.val['type'].cast(u32)
        yield 'dpl',     self.val['dpl'].cast(u32)
        yield 'present', self.val['present'].cast(u32)

def orga2_printers(value):
    if value.type.name == 'gdt_entry_t':
        return GDTPrinter(value)
    if value.type.name == 'idt_entry_t':
        return IDTPrinter(value)
    return None

gdb.pretty_printers.append(orga2_printers)

def load_control_register(name, identifier):
    # Cargo todos los registros según qemu
    qemu_registers = gdb.execute('monitor info registers', to_string=True)
    # Busco al gdt
    descriptors = [reg for reg in qemu_registers.split() if reg.startswith(f"{identifier}=")]
    # Debería haber uno sólo, me quedo con ese
    assert len(descriptors) == 1, f"Detectamos más de un {name}"
    descriptor_text = descriptors[0][len(identifier) + 1:]
    descriptor_value = int(descriptor_text, 16)

    address = descriptor_value & 0xFFFFF000
    pcd = bool(descriptor_value & 0x00000010)
    pwt = bool(descriptor_value & 0x00000008)

    return address, pcd, pwt

def get_pd_entry(base, index):
    addr = base + index * 4

    inferior = gdb.selected_inferior()
    entry_bytes = inferior.read_memory(addr, 4)
    entry = int.from_bytes(entry_bytes, 'little')
    phy = entry & 0xFFFFF000
    a = bool(entry & 0x00000020)
    pcd = bool(entry & 0x00000010)
    pwt = bool(entry & 0x00000008)
    u_s = bool(entry & 0x00000004)
    r_w = bool(entry & 0x00000002)
    p = bool(entry & 0x00000001)

    return phy, a, pcd, pwt, u_s, r_w, p

def get_pt_entry(base, index):
    addr = base + index * 4

    inferior = gdb.selected_inferior()
    entry_bytes = inferior.read_memory(addr, 4)
    entry = int.from_bytes(entry_bytes, 'little')
    phy = entry & 0xFFFFF000
    g = bool(entry & 0x00000100)
    pat = bool(entry & 0x00000080)
    d = bool(entry & 0x00000040)
    a = bool(entry & 0x00000020)
    pcd = bool(entry & 0x00000010)
    pwt = bool(entry & 0x00000008)
    u_s = bool(entry & 0x00000004)
    r_w = bool(entry & 0x00000002)
    p = bool(entry & 0x00000001)

    return phy, g, pat, d, a, pcd, pwt, u_s, r_w, p

def format_flags(flags, names):
    flags_set = []
    for flag, name in zip(flags, names):
        if isinstance(name, str):
            if flag:
                flags_set.append(name)
        else:
            flags_set.append(name[flag])
    return ', '.join(flags_set)

def print_translation(cr3, virtual_addr):
    base, pcd, pwt = cr3

    pd_index = virtual_addr >> 22
    pt_index = (virtual_addr >> 12) & 0x3FF
    offset = virtual_addr & 0xFFF
    print(f'Address ({format_address(virtual_addr)}):')
    print(f'  PD Index: {pd_index:#x}')
    print(f'  PT Index: {pt_index:#x}')
    print(f'  Offset: {offset:#x}')
    print('CR3:')
    print(f'  Base: {format_address(base)}')
    print(f'  Attributes: {format_flags([pcd, pwt], ["PCD", "PWT"]) or "None set"}')

    pd_phy, pd_a, pd_pcd, pd_pwt, pd_u_s, pd_r_w, pd_p = get_pd_entry(base, pd_index)
    if not pd_p:
        print('  PDE Entry -- Not present')
        return
    print(f'  PDE Entry:')
    print(f'    Page Table: {format_address(pd_phy)}')
    print(f'    Attributes: {format_flags([pd_a, pd_pcd, pd_pwt, pd_u_s, pd_r_w], ["Accessed", "PCD", "PWT", ["System", "User"], ["Read-Only", "Read/Write"]])}')
    pt_phy, pt_g, pt_pat, pt_d, pt_a, pt_pcd, pt_pwt, pt_u_s, pt_r_w, pt_p = get_pt_entry(pd_phy, pt_index)
    if not pt_p:
        print('  PTE Entry -- Not present')
        return
    print(f'  PTE Entry:')
    print(f'    Physical Address: {format_address(pt_phy)}')
    print(f'    Attributes: {format_flags([pt_g, pt_d, pt_a, pt_pcd, pt_pwt, pt_u_s, pt_r_w], ["Global", "Dirty", "Accessed", "PCD", "PWT", ["System", "User"], ["Read-Only", "Read/Write"]])}')
    print(f'  Physical Address: {format_address(pt_phy | offset)}')
    print(f'  Attributes: {format_flags([pt_g, pt_d, pt_a, pcd, pd_pcd or pt_pcd, pwt or pd_pwt or pt_pwt, pd_u_s and pt_u_s, pd_r_w and pt_r_w], ["Global", "Dirty", "Accessed", "PCD", "PWT", ["System", "User"], ["Read-Only", "Read/Write"]])}')

@dataclass
class Mapping:
    """Represents a mapping from virtual addresses to physical ones"""
    from_virt: int
    to_virt:int
    from_phy: int
    to_phy: int
    g: bool
    pat: bool
    pcd: bool
    pwt: bool
    u_s: bool
    r_w: bool

def print_mappings(cr3):
    base, pcd, pwt = cr3

    last = None
    mappings = []

    for i in range(1024):
        pd_phy, pd_a, pd_pcd, pd_pwt, pd_u_s, pd_r_w, pd_p = get_pd_entry(base, i)
        if not pd_p:
            continue
        for j in range(1024):
            pt_phy, pt_g, pt_pat, pt_d, pt_a, pt_pcd, pt_pwt, pt_u_s, pt_r_w, pt_p = get_pt_entry(pd_phy, j)
            if not pt_p:
                continue

            effective_pcd = pcd or pd_pcd or pt_pcd
            effective_pwt = pwt or pd_pwt or pt_pwt
            effective_u_s = pd_u_s and pt_u_s
            effective_r_w = pd_r_w and pt_r_w

            pt_virt = (i << 22) | (j << 12)
            continues_previous_phy = last is not None and last.to_phy == pt_phy
            continues_previous_virt = last is not None and last.to_virt == pt_virt
            same_attributes = (last is not None
                           and last.g == pt_g
                           and last.pat == pt_pat
                           and last.pcd == effective_pcd
                           and last.pwt == effective_pwt
                           and last.u_s == effective_u_s
                           and last.r_w == effective_r_w)
            if last is not None and last.to_phy == pt_phy and last.to_virt == pt_virt and same_attributes:
                last.to_phy += 0x1000
                last.to_virt += 0x1000
            else:
                last = Mapping(pt_virt, pt_virt + 0x1000, pt_phy, pt_phy + 0x1000, pt_g, pt_pat, effective_pcd, effective_pwt, effective_u_s, effective_r_w)
                mappings.append(last)
    rows = [('Virtual Range', '|', 'Physical Range', '|', 'Length', '|', 'Attributes')]
    for mapping in mappings:
        rows.append((
            f'0x{mapping.from_virt:0>8x}-0x{mapping.to_virt:0>8x}', '|',
            f'0x{mapping.from_phy:0>8x}-0x{mapping.to_phy:0>8x}',   '|',
            f'{mapping.to_phy - mapping.from_phy:#x}',            '|',
            format_flags([mapping.g, mapping.pcd, mapping.pwt, mapping.u_s, mapping.r_w],
                         ['Global', 'PCD', 'PWT', ['System', 'User'], ['Read-Only', 'Read-Write']]),
        ))
    print_table(rows)

class InfoPageCommand(gdb.Command):
    """Shows paging information
  info page -- Show a summary of the paging configuration
  info page directory -- Shows present entries in the page directory
  info page table [idx] -- Shows present entries for the given page table
  info page [addr] -- Shows paging information for the given virtual address"""
    def __init__(self):
        super().__init__('info page', gdb.COMMAND_STATUS, gdb.COMPLETE_NONE, True)

    def invoke(self, argument, from_tty):
        cr3 = load_control_register('cr3', 'CR3')

        if argument == '':
            print_mappings(cr3)
        else:
            u32 = gdb.lookup_type('unsigned int')
            virtual_addr = int(gdb.parse_and_eval(argument).cast(u32))
            print_translation(cr3, virtual_addr)

class InfoPageDirectoryCommand(gdb.Command):
    """Shows present entries in the given page frame"""
    def __init__(self):
        super().__init__('info page directory', gdb.COMMAND_STATUS, gdb.COMPLETE_NONE, False)

    def invoke(self, argument, from_tty):
        base, pcd, pwt = load_control_register('cr3', 'CR3')

        rows = [(
            'cr3', '=',
            'Base:', format_address(base) + ',',
            'Attributes:', (format_flags([pcd, pwt], ['PCD', 'PWT']) or 'None set')
        )]

        for i in range(1024):
            phy, a, pcd, pwt, u_s, r_w, p = get_pd_entry(base, i)
            if not p:
                continue
            rows.append((
                f'pd[{i:#x}]', '=',
                'Page Table:', format_address(phy) + ',',
                'Attributes:', format_flags([a, pcd, pwt, u_s, r_w], ["Accessed", "PCD", "PWT", ["System", "User"], ["Read-Only", "Read/Write"]])
            ))

        print_table(rows)

class InfoPageTableCommand(gdb.Command):
    """Shows present entries for the given page table"""
    def __init__(self):
        super().__init__('info page table', gdb.COMMAND_STATUS, gdb.COMPLETE_EXPRESSION, False)

    def invoke(self, argument, from_tty):
        u32 = gdb.lookup_type('unsigned int')
        pd_index = int(gdb.parse_and_eval(argument).cast(u32))

        base, pcd, pwt = load_control_register('cr3', 'CR3')
        rows = [(
            'cr3', '=',
            'Base:', format_address(base) + ',',
            'Attributes:', (format_flags([pcd, pwt], ['PCD', 'PWT']) or 'None set')
        )]

        pd_phy, a, pcd, pwt, u_s, r_w, p = get_pd_entry(base, pd_index)
        if not p:
            rows.append((f'pd[{pd_index:#x}]', '--' , 'Not present'))
            print_table(rows)
            return
        rows.append((
            f'pd[{pd_index:#x}]', '=',
            'Page Table:', format_address(pd_phy) + ',',
            'Attributes:', format_flags([a, pcd, pwt, u_s, r_w], ["Accessed", "PCD", "PWT", ["System", "User"], ["Read-Only", "Read/Write"]])
        ))

        for i in range(1024):
            phy, g, pat, d, a, pcd, pwt, u_s, r_w, p = get_pt_entry(pd_phy, i)
            if not p:
                continue
            rows.append((
                f'pt[{i:#x}]', '=',
                'Physical Address:', format_address(phy) + ',',
                'Attributes:', format_flags([g, d, a, pcd, pwt, u_s, r_w], ["Global", "Dirty", "Accessed", "PCD", "PWT", ["System", "User"], ["Read-Only", "Read/Write"]])
            ))

        print_table(rows)

InfoPageCommand()
InfoPageDirectoryCommand()
InfoPageTableCommand()

class XPCommand(gdb.Command):
    """Shows present entries for the given page table"""
    def __init__(self):
        super().__init__('xp', gdb.COMMAND_STATUS, gdb.COMPLETE_EXPRESSION, False)

    def invoke(self, arguments, from_tty):
        u32 = gdb.lookup_type('unsigned int')

        previous_mode = gdb.execute('maintenance packet qqemu.PhyMemMode', to_string=True)
        is_virtual = 'sending: qqemu.PhyMemMode\nreceived: "0"\n'
        is_physical = 'sending: qqemu.PhyMemMode\nreceived: "1"\n'
        assert previous_mode == is_virtual or previous_mode == is_physical
        previous_mode = int(previous_mode == is_physical)

        # Change to physical mode
        response = gdb.execute('maintenance packet Qqemu.PhyMemMode:1', to_string=True)
        assert response == 'sending: Qqemu.PhyMemMode:1\nreceived: "OK"\n'
        # Run X
        gdb.execute(f'x {arguments}')
        response = gdb.execute(f'maintenance packet Qqemu.PhyMemMode:{previous_mode}', to_string=True)
        assert response == f'sending: Qqemu.PhyMemMode:{previous_mode}\nreceived: "OK"\n'

XPCommand()
