extends Node

signal interaction(icon, text)
signal UpdatedJournal
signal JournalCollected
signal NewLoop
signal Complete

var JournalEntries:Array = []
var FoundJournal:bool = false
var ParallaxReducer:bool = false
var MachineStage:int = 0
var HasKey:bool = false

var Restarts:int = 0
var CorrectOrder:bool = true

func _reset():
	# Reset vars to default
	JournalEntries = []
	FoundJournal = false
	ParallaxReducer = false
	MachineStage = 0
	HasKey = false
	
	Restarts += 1
	SceneManager._reload_scene()
