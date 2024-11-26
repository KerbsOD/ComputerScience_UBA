#include <iostream>
#include <assert.h>
#include <cstring>

#include "../include/hdd.h"
#include "../include/mbr.h"
#include "../include/pentry.h"
#include "../include/ext2fs.h"

using namespace std;

void test_file_system(Ext2FS * fs){
	cout << "=== Filesystem Superblock ===" << endl;
	cout << *(fs->superblock()) << endl;

	//Verifico que la informacion de la cantidad de bloques sea la esperada
	assert(fs->superblock()->blocks_count == 102400);
}

void test_hdd(HDD * hdd){
	unsigned char buffer[SECTOR_SIZE];
	hdd->read(0, buffer);
	MBR mbr(buffer);
	const PartitionEntry & pentry = mbr[1];
	cout << "=== Partition Data ===" << endl;
	cout << pentry << endl << endl;

	//Verifico que la LBA empiece donde se espera
	assert(pentry.start_lba() == 4096);
}

void test_block_groups(Ext2FS * fs){
	cout << "=== Block Groups Data ===" << endl;
	unsigned int block_groups = fs->block_groups();
	for(unsigned int i = 0; i < block_groups; i++)
	{
		cout << *(fs->block_group(i)) << endl;
	}
	Ext2FSBlockGroupDescriptor block_group = *(fs->block_group(1));

	//Verifico que el block group 1 tenga la información correcta
	assert(block_group.block_bitmap == 8195);
}

void test_load_inode(Ext2FS * fs){
	cout << "=== Test Load Inode ===" << endl;
    Ext2FSInode *inodo = fs->load_inode(23674);
    assert(inodo->size == 1024);
    inodo = fs->load_inode(23673);
    assert(inodo->size == 8961201);
	cout << "All tests succeed! " << endl;
}

void test_get_block_address_direct(Ext2FS * fs, Ext2FSInode *inodo){
	cout << "  ** Testing Direct Entries **" << endl;
	int assert_block_address = 55334;
	for(int i = 0; i < 13; i++){
		int address = fs->get_block_address(inodo,i);
		assert(address == assert_block_address);
		assert_block_address++;
	}
	cout << "  -- Success! -- " << endl;
}

void test_get_block_address_first_indirect(Ext2FS * fs, Ext2FSInode *inodo){
	cout << "  ** Testing First Indirect Entries **" << endl;

	int assert_block_address = 69715;
	int address = fs->get_block_address(inodo, 50);
	assert(address == assert_block_address);

	address = fs->get_block_address(inodo, 223);
	assert_block_address = 69984;
	assert(address == assert_block_address);

	cout << "  -- Success! -- " << endl;
}

void test_get_block_address_second_indirect(Ext2FS * fs, Ext2FSInode *inodo){
	cout << "  ** Testing Second Indirect Entries **" << endl;

	int assert_block_address = 70389;
	int address = fs->get_block_address(inodo, 500);
	assert(address == assert_block_address);

	address = fs->get_block_address(inodo, 1500);
	assert_block_address = 75214;
	assert(address == assert_block_address);

	cout << "  -- Success! -- " << endl;
}

void test_get_block_address(Ext2FS * fs){
	cout << "=== Test Get Block Address ===" << endl;    
    Ext2FSInode *inodo = fs->load_inode(23674);
    assert(inodo->size == 1024);
    int address = fs->get_block_address(inodo,0);
    assert(address == 52225);

    inodo = fs->load_inode(23673);
    test_get_block_address_direct(fs, inodo);
	test_get_block_address_first_indirect(fs, inodo);
	test_get_block_address_second_indirect(fs, inodo);
	cout << "All tests succeed! " << endl;
	
}

void test_dir_entry_contained_one_block(Ext2FS * fs){
	cout << "  ** Test DirEntry which is contained in one block **" << endl;
    unsigned char caracteres[9];
	fd_t fileDesc = fs->open("/grupos/g1/nota.txt", "cualquiera");
	fs->seek(fileDesc,13999);
	fs->read(fileDesc,caracteres,8);
	caracteres[8]=0;
	string character_string(reinterpret_cast<const char*>(caracteres));
	string expected_string = "GRUPO 01";
	if (character_string != expected_string) {
		cout << " -- Wrong Answer --" << endl;
		cout << "Expected answer: " << expected_string << endl;
		cout << "But got: " << character_string << endl;
	} else {
		cout << "  -- Success! -- " << endl;
	}
}

void test_dir_entry_contained_in_two_blocks(Ext2FS * fs){
	cout << "  ** Test DirEntry which is in two blocks **" << endl;
	unsigned char caracteres[9];
	fd_t fileDesc = fs->open("/grupos/g72/0123456789012345678901234567891;", "cualquiera");
	fs->read(fileDesc,caracteres,8);
	string character_string(reinterpret_cast<const char*>(caracteres));
	string expected_string = "GRUPO 72";
	if (character_string != expected_string) {
		cout << " -- Wrong Answer --" << endl;
		cout << "Expected answer: " << expected_string << endl;
		cout << "But got: " << character_string << endl;
	} else {
		cout << "  -- Success! -- " << endl;
	}
}

void test_dir_entry_does_not_exists(Ext2FS * fs){
	cout << "  ** Test DirEntry does not exist **" << endl;
	unsigned char caracteres[9];
	fd_t fileDesc = fs->open("/grupos/g100", "cualquiera");
	assert(fileDesc == -1);
	cout << "  -- Success! -- " << endl;
}


void test_get_file_inode_from_dir_inode(Ext2FS * fs){
	cout << "=== Test Get File Inode From Directory Inode ===" << endl;
	test_dir_entry_contained_one_block(fs);
	test_dir_entry_contained_in_two_blocks(fs);
	test_dir_entry_does_not_exists(fs);
	cout << "All tests succeed! " << endl;

}
int main(int argc, char ** argv)
{
	HDD hdd(argv[1]);

	//Esto lo pueden comentar. Es sólo para ver si descomprimieron bien la imagen de disco
	//test_hdd(&hdd);

	Ext2FS * fs = new Ext2FS(hdd, 1);
        
    //Esto lo pueden comentar. Es sólo para ver si el FS está bien
	//test_file_system(fs);

	//Esto lo pueden comentar. Es sólo para ver si el FS está bien
	//test_block_groups(fs);

	
    //Test ejercicios
    test_load_inode(fs);
    test_get_block_address(fs);
    test_get_file_inode_from_dir_inode(fs);
    
	return 0;
}
