extends Node

# Signal Handler
signal interaction(icon, text)
signal UpdatedJournal
signal JournalCollected
signal NewLoop
signal Complete

# Unsaved vars
var JournalEntries:Array = []
var FoundJournal:bool = false
var ParallaxReducer:bool = false
var MachineStage:int = 0
var HasKey:bool = false
var CorrectOrder:bool = true
var Restarts:int = 0

# Randomized vars
var KeyNum
var KeypadNum:int
var SecurityOrder = ["South","North","East","West"]

# Saving/Loading
const SavePath := "user://groundhog.dat"
var CanPoll:int = 0

func _ready():
	randomize()
	KeyNum = randi_range(1000, 9999)
	for i in range(0, 7):
		var digit:int = randi_range(1, 9)
		@warning_ignore("narrowing_conversion")
		KeypadNum += digit * pow(10, i)
	print(KeypadNum)
	SecurityOrder.shuffle()
	
	if not FileAccess.file_exists(SavePath):
		_save()
	else:
		_load()

func _save():
	var file := FileAccess.open(SavePath, FileAccess.WRITE)
	file.store_64(CanPoll)

func _load():
	var file := FileAccess.open(SavePath, FileAccess.READ)
	CanPoll = file.get_64()

func _reset():
	# Reset vars to default
	JournalEntries = []
	FoundJournal = false
	ParallaxReducer = false
	MachineStage = 0
	HasKey = false
	CorrectOrder = true
