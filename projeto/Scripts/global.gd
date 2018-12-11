extends Node

# onready var firstNode = get_tree().get_root().get_child(0);
var firstNode;
var canvas;
var root;

func _ready():
	root = get_tree().get_root();
	firstNode = root.get_child(root.get_child_count() -1);
	canvas = firstNode.get_node("CanvasLayer");
	# current_scene = root.get_child(root.get_child_count() -1)
	
func set_parent(parent, node):
	var nodeParent = node.get_parent(); 
	if (nodeParent == parent):
		return;
		
	nodeParent.remove_child(node);
	print(nodeParent.is_a_parent_of(parent))
	parent.add_child(node);
	