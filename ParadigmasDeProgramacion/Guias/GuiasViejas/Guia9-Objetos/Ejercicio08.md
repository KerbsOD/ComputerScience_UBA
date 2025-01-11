a) #curry 
	^ [:x | [:y | self value: x value: y] ] .

b) #flip 
	^ [:x :y | self value: y value: x ] .
    
    | block |
    block := [:x :y | x > y ] flip.
    block value: 10 value: 5.

c) #timesRepeat:
    | count |
	count := 1.
	[count <= self] whileTrue:
	[aBlock value. count := count + 1]


