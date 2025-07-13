extends Node

var done_collumns = [0]

var current_map = 'map1'

var max_layers = {
	'map1': 3,
	'map2': 4,
}

var next_maps = {
	'map1': ['map2'],
	'map2': ['map1'],
}
