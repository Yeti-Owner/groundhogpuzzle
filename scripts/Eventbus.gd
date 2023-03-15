extends Node

signal interaction(icon, text)
signal UpdatedJournal
signal JournalCollected
signal NewLoop

var JournalEntries:Array = []
var FoundJournal:bool = false
var ParallaxReducer:bool = false
