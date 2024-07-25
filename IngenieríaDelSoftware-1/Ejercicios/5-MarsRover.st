!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'movingBackwards' stamp: 'OK 5/11/2024 22:57:33'!
test06RoverFacingNorthOnBackwardsUpdatesYAxisCorrectly
	|rover|
	
	rover := MarsRover withStartingPosition: (2@3) facing: 'N'  withSize: 3@3.
	
	rover recieveCommands: 'b'.
	
	self assert: rover position = (2@2). ! !

!MarsRoverTest methodsFor: 'movingBackwards' stamp: 'OK 5/11/2024 22:57:33'!
test07RoverFacingEastOnBackwardsUpdatesXAxisCorrectly
	|rover|
	
	rover := MarsRover withStartingPosition: (1@0) facing: 'E'  withSize: 3@3.
	
	rover recieveCommands: 'b'.
	
	self assert: rover position = (0@0). ! !

!MarsRoverTest methodsFor: 'movingBackwards' stamp: 'OK 5/11/2024 22:57:33'!
test08RoverFacingSouthOnBackwardsUpdatesYAxisCorrectly
	|rover|
	
	rover := MarsRover withStartingPosition: (0@2) facing: 'S'  withSize: 3@3.
	
	rover recieveCommands: 'b'.
	
	self assert: rover position = (0@3). ! !

!MarsRoverTest methodsFor: 'movingBackwards' stamp: 'OK 5/11/2024 22:57:33'!
test09RoverFacingWestOnBackwardsUpdatesXAxisCorrectly
	|rover|
	
	rover := MarsRover withStartingPosition: (1@1) facing: 'W'  withSize: 3@3.
	
	rover recieveCommands: 'b'.
	
	self assert: rover position = (2@1). ! !


!MarsRoverTest methodsFor: 'setup' stamp: 'OK 5/9/2024 04:13:29'!
test01PositionRoverOutsideBoundsRisesError
	
	self 
		should: [ MarsRover withStartingPosition: (4@3) facing: 'N' withSize: 3@3]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'Posicion 4@3 fuera del sitio de excavacion']! !


!MarsRoverTest methodsFor: 'invalidCommand' stamp: 'OK 5/11/2024 22:57:33'!
test18WrongCommandInvalidatesNextCommands
	|rover|
	
	rover := MarsRover withStartingPosition: (1@1) facing: 'N'  withSize: 3@3.
	
	rover recieveCommands: 'fxf'.
	
	self assert: rover position = (1@2). ! !


!MarsRoverTest methodsFor: 'turningLeft' stamp: 'OK 5/11/2024 22:57:33'!
test14RoverFacingNorthFaceWestWhenTurningLeft
	|rover|
	
	rover := MarsRover withStartingPosition: (1@1) facing: 'N'  withSize: 3@3.
	
	rover recieveCommands: 'l'.
	
	self assert: rover facing = 'W'. ! !

!MarsRoverTest methodsFor: 'turningLeft' stamp: 'OK 5/11/2024 22:57:33'!
test15RoverFacingWestFaceSouthWhenTurningLeft
	|rover|
	
	rover := MarsRover withStartingPosition: (1@1) facing: 'W'  withSize: 3@3.
	
	rover recieveCommands: 'l'.
	
	self assert: rover facing = 'S'. ! !

!MarsRoverTest methodsFor: 'turningLeft' stamp: 'OK 5/11/2024 22:57:33'!
test16RoverFacingSouthFaceEastWhenTurningLeft
	|rover|
	
	rover := MarsRover withStartingPosition: (1@1) facing: 'S'  withSize: 3@3.
	
	rover recieveCommands: 'l'.
	
	self assert: rover facing = 'E'. ! !

!MarsRoverTest methodsFor: 'turningLeft' stamp: 'OK 5/11/2024 22:57:33'!
test17RoverFacingEastFaceNorthWhenTurningLeft
	|rover|
	
	rover := MarsRover withStartingPosition: (1@1) facing: 'E'  withSize: 3@3.
	
	rover recieveCommands: 'l'.
	
	self assert: rover facing = 'N'. ! !


!MarsRoverTest methodsFor: 'turningRight' stamp: 'OK 5/11/2024 22:57:33'!
test10RoverFacingNorthFaceEastWhenTurningRight
	|rover|
	
	rover := MarsRover withStartingPosition: (1@1) facing: 'N'  withSize: 3@3.
	
	rover recieveCommands: 'r'.
	
	self assert: rover facing = 'E'. ! !

!MarsRoverTest methodsFor: 'turningRight' stamp: 'OK 5/11/2024 22:57:33'!
test11RoverFacingEastFaceSouthWhenTurningRight
	|rover|
	
	rover := MarsRover withStartingPosition: (1@1) facing: 'E'  withSize: 3@3.
	
	rover recieveCommands: 'r'.
	
	self assert: rover facing = 'S'. ! !

!MarsRoverTest methodsFor: 'turningRight' stamp: 'OK 5/11/2024 22:57:33'!
test12RoverFacingSouthFaceWestWhenTurningRight
	|rover|
	
	rover := MarsRover withStartingPosition: (1@1) facing: 'S'  withSize: 3@3.
	
	rover recieveCommands: 'r'.
	
	self assert: rover facing = 'W'. ! !

!MarsRoverTest methodsFor: 'turningRight' stamp: 'OK 5/11/2024 22:57:33'!
test13RoverFacingWestFaceNorthWhenTurningRight
	|rover|
	
	rover := MarsRover withStartingPosition: (1@1) facing: 'W'  withSize: 3@3.
	
	rover recieveCommands: 'r'.
	
	self assert: rover facing = 'N'. ! !


!MarsRoverTest methodsFor: 'movingForward' stamp: 'OK 5/11/2024 22:57:33'!
test02RoverFacingNorthOnForwardUpdatesYAxisCorrectly
	|rover|
	
	rover := MarsRover withStartingPosition: (1@1) facing: 'N'  withSize: 3@3.
	
	rover recieveCommands: 'f'.
	
	self assert: rover position = (1@2). ! !

!MarsRoverTest methodsFor: 'movingForward' stamp: 'OK 5/11/2024 22:57:33'!
test03RoverFacingEastOnForwardUpdatesXAxisCorrectly
	|rover|
	
	rover := MarsRover withStartingPosition: (1@2) facing: 'E'  withSize: 3@3.
	
	rover recieveCommands: 'f'.
	
	self assert: rover position = (2@2). ! !

!MarsRoverTest methodsFor: 'movingForward' stamp: 'OK 5/11/2024 22:57:33'!
test04RoverFacingSouthOnForwardUpdatesYAxisCorrectly
	
	|rover|
	
	rover := MarsRover withStartingPosition: (3@3) facing: 'S'  withSize: 3@3.
	
	rover recieveCommands: 'f'.
	
	self assert: rover position = (3@2). ! !

!MarsRoverTest methodsFor: 'movingForward' stamp: 'OK 5/11/2024 22:57:33'!
test05RoverFacingWestOnForwardUpdatesXAxisCorrectly
	|rover|
	
	rover := MarsRover withStartingPosition: (2@0) facing: 'W'  withSize: 3@3.
	
	rover recieveCommands: 'f'.
	
	self assert: rover position = (1@0). ! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position size acceptingCommands status'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialize' stamp: 'OK 5/12/2024 11:46:36'!
initializeWithPosition: aPointPosition facing: aCardinalCoordinate withSize: aSiteSize
	position := aPointPosition.
	size := aSiteSize.
	acceptingCommands := true.
	status  := (MarsRoverFacingState subclasses detect: [:aFacingRoverState | aFacingRoverState canHandle: aCardinalCoordinate]) new.! !


!MarsRover methodsFor: 'testing' stamp: 'OK 5/11/2024 22:36:19'!
facing
	^ status currentlyFacing.! !

!MarsRover methodsFor: 'testing' stamp: 'OK 5/9/2024 02:20:20'!
position
	^ position.! !


!MarsRover methodsFor: 'status - private' stamp: 'OK 5/12/2024 11:47:18'!
executeCommandWhileFacingEast: aCommand

	self regardingTheCommand: aCommand 
		ifForward: ((position x + 1)@(position y))
		ifBackwards: ((position x - 1)@(position y))
		ifRightTurn: (FacingSouth new) 
		ifLeftTurn: (FacingNorth new)
! !

!MarsRover methodsFor: 'status - private' stamp: 'OK 5/12/2024 11:47:28'!
executeCommandWhileFacingNorth: aCommand
	
	self regardingTheCommand: aCommand 
		ifForward: ((position x)@(position y + 1))
		ifBackwards: ((position x)@(position y - 1))
		ifRightTurn: (FacingEast new) 
		ifLeftTurn: (FacingWest new)! !

!MarsRover methodsFor: 'status - private' stamp: 'OK 5/12/2024 11:47:28'!
executeCommandWhileFacingSouth: aCommand
	
	self regardingTheCommand: aCommand 
		ifForward: ((position x)@(position y - 1))
		ifBackwards: ((position x)@(position y + 1))
		ifRightTurn: (FacingWest new) 
		ifLeftTurn: (FacingEast new)! !

!MarsRover methodsFor: 'status - private' stamp: 'OK 5/12/2024 11:47:18'!
executeCommandWhileFacingWest: aCommand

	self regardingTheCommand: aCommand 
		ifForward: ((position x - 1)@(position y))
		ifBackwards: ((position x + 1)@(position y))
		ifRightTurn: (FacingNorth new) 
		ifLeftTurn: (FacingSouth new)! !


!MarsRover methodsFor: 'private' stamp: 'OK 5/11/2024 22:00:01'!
checkIsValidCommand: command
	
	((command = $f) or:
	(command = $b) or:
	(command = $r) or:
	(command = $l)) ifFalse: [
		acceptingCommands := false.	
	].! !

!MarsRover methodsFor: 'private' stamp: 'OK 5/11/2024 22:37:29'!
executeCommand: command
	
	status executeCommand: command on: self.
	! !

!MarsRover methodsFor: 'private' stamp: 'OK 5/11/2024 23:03:21'!
regardingTheCommand: aCommand ifForward: forwardPosition ifBackwards: backwardsPosition ifRightTurn: rightCoordinateObject ifLeftTurn: leftCoordinateObject

	aCommand = $f ifTrue: [
		position := forwardPosition
	].
	aCommand = $b ifTrue: [
		position := backwardsPosition
	].
	aCommand = $r ifTrue: [
		status := rightCoordinateObject
	].
	aCommand = $l ifTrue: [
		status := leftCoordinateObject
	].! !

!MarsRover methodsFor: 'private' stamp: 'OK 5/11/2024 22:37:35'!
validStringOfCommands

	^ acceptingCommands.! !


!MarsRover methodsFor: 'actions' stamp: 'OK 5/11/2024 22:56:48'!
recieveCommands: aStringOfCommands
	
	aStringOfCommands do: [:command | 
		self checkIsValidCommand: command.
		(self validStringOfCommands) ifTrue: [
			self executeCommand: command.	
		].
	].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'OK 5/9/2024 04:12:58'!
assertRover: theRoverPosition isInside: aSiteSize
	|origin|
	
	origin := 0@0.
				
	(theRoverPosition between: origin and: aSiteSize) ifFalse: [
		self error: 'Posicion ', theRoverPosition printString, ' fuera del sitio de excavacion'
	].! !

!MarsRover class methodsFor: 'initialization' stamp: 'OK 5/9/2024 04:09:29'!
withStartingPosition: theRoverPosition facing: aCardinalCoordinate withSize: aSiteSize
	
	self assertRover: theRoverPosition isInside: aSiteSize.

	^ self new initializeWithPosition: theRoverPosition facing: aCardinalCoordinate withSize: aSiteSize.! !


!classDefinition: #MarsRoverFacingState category: #MarsRover!
Object subclass: #MarsRoverFacingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverFacingState methodsFor: 'as yet unclassified' stamp: 'OK 5/11/2024 22:38:32'!
currentlyFacing
	
	self subclassResponsibility ! !

!MarsRoverFacingState methodsFor: 'as yet unclassified' stamp: 'OK 5/11/2024 22:38:50'!
executeCommand: aCommand on: aRover

	self subclassResponsibility 

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverFacingState class' category: #MarsRover!
MarsRoverFacingState class
	instanceVariableNames: ''!

!MarsRoverFacingState class methodsFor: 'as yet unclassified' stamp: 'OK 5/11/2024 22:15:32'!
canHandle: aCardinalCoordinate
	self subclassResponsibility.! !


!classDefinition: #FacingEast category: #MarsRover!
MarsRoverFacingState subclass: #FacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!FacingEast methodsFor: 'as yet unclassified' stamp: 'OK 5/11/2024 22:35:36'!
currentlyFacing
	^'E'.! !

!FacingEast methodsFor: 'as yet unclassified' stamp: 'OK 5/11/2024 22:20:20'!
executeCommand: aCommand on: aRover

	aRover executeCommandWhileFacingEast: aCommand.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FacingEast class' category: #MarsRover!
FacingEast class
	instanceVariableNames: ''!

!FacingEast class methodsFor: 'as yet unclassified' stamp: 'OK 5/11/2024 22:14:45'!
canHandle: aCardinalCoordinate
	^aCardinalCoordinate = 'E'.! !


!classDefinition: #FacingNorth category: #MarsRover!
MarsRoverFacingState subclass: #FacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!FacingNorth methodsFor: 'as yet unclassified' stamp: 'OK 5/11/2024 22:35:47'!
currentlyFacing
	^'N'.! !

!FacingNorth methodsFor: 'as yet unclassified' stamp: 'OK 5/11/2024 22:19:55'!
executeCommand: aCommand on: aRover

	aRover executeCommandWhileFacingNorth: aCommand.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FacingNorth class' category: #MarsRover!
FacingNorth class
	instanceVariableNames: ''!

!FacingNorth class methodsFor: 'as yet unclassified' stamp: 'OK 5/11/2024 22:14:57'!
canHandle: aCardinalCoordinate
	^aCardinalCoordinate = 'N'.! !


!classDefinition: #FacingSouth category: #MarsRover!
MarsRoverFacingState subclass: #FacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!FacingSouth methodsFor: 'as yet unclassified' stamp: 'OK 5/11/2024 22:35:56'!
currentlyFacing
	^'S'.! !

!FacingSouth methodsFor: 'as yet unclassified' stamp: 'OK 5/11/2024 22:20:36'!
executeCommand: aCommand on: aRover

	aRover executeCommandWhileFacingSouth: aCommand.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FacingSouth class' category: #MarsRover!
FacingSouth class
	instanceVariableNames: ''!

!FacingSouth class methodsFor: 'as yet unclassified' stamp: 'OK 5/11/2024 22:15:06'!
canHandle: aCardinalCoordinate
	^aCardinalCoordinate = 'S'.! !


!classDefinition: #FacingWest category: #MarsRover!
MarsRoverFacingState subclass: #FacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!FacingWest methodsFor: 'as yet unclassified' stamp: 'OK 5/11/2024 22:36:03'!
currentlyFacing
	^'W'.! !

!FacingWest methodsFor: 'as yet unclassified' stamp: 'OK 5/11/2024 22:20:54'!
executeCommand: aCommand on: aRover

	aRover executeCommandWhileFacingWest: aCommand.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FacingWest class' category: #MarsRover!
FacingWest class
	instanceVariableNames: ''!

!FacingWest class methodsFor: 'as yet unclassified' stamp: 'OK 5/11/2024 22:15:16'!
canHandle: aCardinalCoordinate
	^aCardinalCoordinate = 'W'.! !
