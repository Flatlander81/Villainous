@tool
extends EditorScript

## Tactical Framework Bootstrap Tool
##
## This script sets up the complete project structure for the tactical framework.
## Run this from the Godot editor: File -> Run
##
## What it creates:
## - Complete directory structure
## - Stub GDScript files with proper class_name declarations
## - Basic scene files (.tscn) with node hierarchies
## - Default resource files (.tres)

var created_files := []
var created_dirs := []
var skipped_files := []

func _run() -> void:
	print("=" * 80)
	print("TACTICAL FRAMEWORK BOOTSTRAP TOOL")
	print("=" * 80)
	print()

	create_directory_structure()
	create_framework_scripts()
	create_scene_files()
	create_resource_files()
	print_summary()
	print_next_steps()

## ============================================================================
## DIRECTORY CREATION
## ============================================================================

func create_directory_structure() -> void:
	print("Creating directory structure...")

	var directories := [
		# Framework directories
		"res://Framework/Grid",
		"res://Framework/Movement",
		"res://Framework/Combat",
		"res://Framework/Cover",
		"res://Framework/Units",
		"res://Framework/Turns",
		"res://Framework/Camera",
		"res://Framework/UI",
		"res://Framework/Audio",

		# Scene directories
		"res://Scenes/Test",
		"res://Scenes/Units",
		"res://Scenes/Cover",
		"res://Scenes/Levels",

		# Resource directories
		"res://Resources/Units",
		"res://Resources/Weapons",

		# Asset directories
		"res://Assets/Textures",
		"res://Assets/Audio",
		"res://Assets/UI",
	]

	for dir_path in directories:
		create_directory(dir_path)

	print("  ✓ Directory structure created\n")

func create_directory(path: String) -> void:
	var dir := DirAccess.open("res://")
	if dir.dir_exists(path):
		return

	if dir.make_dir_recursive(path) == OK:
		created_dirs.append(path)
		print("  [+] Created: %s" % path)
	else:
		printerr("  [!] Failed to create: %s" % path)

## ============================================================================
## FRAMEWORK SCRIPTS
## ============================================================================

func create_framework_scripts() -> void:
	print("\nCreating framework scripts...")

	# Grid System
	create_script("res://Framework/Grid/grid_manager.gd", get_grid_manager_template())
	create_script("res://Framework/Grid/grid_cell.gd", get_grid_cell_template())

	# Movement System
	create_script("res://Framework/Movement/movement_system.gd", get_movement_system_template())
	create_script("res://Framework/Movement/pathfinding.gd", get_pathfinding_template())

	# Combat System
	create_script("res://Framework/Combat/combat_system.gd", get_combat_system_template())
	create_script("res://Framework/Combat/damage_calculator.gd", get_damage_calculator_template())

	# Cover System
	create_script("res://Framework/Cover/cover_system.gd", get_cover_system_template())
	create_script("res://Framework/Cover/cover_point.gd", get_cover_point_template())

	# Unit System
	create_script("res://Framework/Units/tactical_unit.gd", get_tactical_unit_template())
	create_script("res://Framework/Units/unit_stats.gd", get_unit_stats_template())

	# Turn System
	create_script("res://Framework/Turns/turn_manager.gd", get_turn_manager_template())
	create_script("res://Framework/Turns/action_queue.gd", get_action_queue_template())

	# Camera System
	create_script("res://Framework/Camera/tactical_camera.gd", get_tactical_camera_template())

	# UI System
	create_script("res://Framework/UI/ui_manager.gd", get_ui_manager_template())
	create_script("res://Framework/UI/action_panel.gd", get_action_panel_template())

	# Audio System
	create_script("res://Framework/Audio/audio_manager.gd", get_audio_manager_template())

	print("  ✓ Framework scripts created\n")

func create_script(path: String, content: String) -> void:
	if FileAccess.file_exists(path):
		skipped_files.append(path)
		print("  [-] Skipped (exists): %s" % path)
		return

	var file := FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(content)
		file.close()
		created_files.append(path)
		print("  [+] Created: %s" % path)
	else:
		printerr("  [!] Failed to create: %s" % path)

## ============================================================================
## SCENE FILES
## ============================================================================

func create_scene_files() -> void:
	print("\nCreating scene files...")

	create_scene("res://Scenes/Test/test_grid.tscn", get_test_grid_scene())
	create_scene("res://Scenes/Units/tactical_unit.tscn", get_tactical_unit_scene())
	create_scene("res://Scenes/Cover/low_cover.tscn", get_low_cover_scene())
	create_scene("res://Scenes/Cover/high_cover.tscn", get_high_cover_scene())
	create_scene("res://Scenes/Levels/test_level.tscn", get_test_level_scene())

	print("  ✓ Scene files created\n")

func create_scene(path: String, content: String) -> void:
	if FileAccess.file_exists(path):
		skipped_files.append(path)
		print("  [-] Skipped (exists): %s" % path)
		return

	var file := FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(content)
		file.close()
		created_files.append(path)
		print("  [+] Created: %s" % path)
	else:
		printerr("  [!] Failed to create: %s" % path)

## ============================================================================
## RESOURCE FILES
## ============================================================================

func create_resource_files() -> void:
	print("\nCreating resource files...")

	create_resource("res://Resources/Units/default_unit_stats.tres", get_unit_stats_resource())
	create_resource("res://Resources/Weapons/default_weapon.tres", get_weapon_resource())

	print("  ✓ Resource files created\n")

func create_resource(path: String, content: String) -> void:
	if FileAccess.file_exists(path):
		skipped_files.append(path)
		print("  [-] Skipped (exists): %s" % path)
		return

	var file := FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(content)
		file.close()
		created_files.append(path)
		print("  [+] Created: %s" % path)
	else:
		printerr("  [!] Failed to create: %s" % path)

## ============================================================================
## SUMMARY & NEXT STEPS
## ============================================================================

func print_summary() -> void:
	print("=" * 80)
	print("SUMMARY")
	print("=" * 80)
	print("  Directories created: %d" % created_dirs.size())
	print("  Files created: %d" % created_files.size())
	print("  Files skipped: %d" % skipped_files.size())
	print()

func print_next_steps() -> void:
	print("=" * 80)
	print("NEXT STEPS")
	print("=" * 80)
	print("""
1. REVIEW THE STRUCTURE
   - Check Framework/ for all system scripts
   - Review Scenes/ for scene templates
   - Examine Resources/ for default resources

2. CONFIGURE AUTOLOADS (Project Settings -> Autoload)
   Add these singletons in order:
   - GridManager: res://Framework/Grid/grid_manager.gd
   - TurnManager: res://Framework/Turns/turn_manager.gd
   - CombatSystem: res://Framework/Combat/combat_system.gd
   - UIManager: res://Framework/UI/ui_manager.gd
   - AudioManager: res://Framework/Audio/audio_manager.gd

3. IMPLEMENT CORE SYSTEMS (in this order)
   a) Grid System (grid_manager.gd, grid_cell.gd)
   b) Unit System (tactical_unit.gd, unit_stats.gd)
   c) Movement System (movement_system.gd, pathfinding.gd)
   d) Turn System (turn_manager.gd, action_queue.gd)
   e) Combat System (combat_system.gd, damage_calculator.gd)
   f) Cover System (cover_system.gd, cover_point.gd)
   g) Camera System (tactical_camera.gd)
   h) UI System (ui_manager.gd, action_panel.gd)
   i) Audio System (audio_manager.gd)

4. TEST THE FRAMEWORK
   - Open Scenes/Test/test_grid.tscn
   - Press F6 to run the current scene
   - Verify grid visualization and unit placement

5. CUSTOMIZE RESOURCES
   - Edit Resources/Units/default_unit_stats.tres
   - Edit Resources/Weapons/default_weapon.tres
   - Create additional unit and weapon variants

6. BUILD GAME CONTENT
   - Design levels in Scenes/Levels/
   - Create unit prefabs in Scenes/Units/
   - Add cover objects in Scenes/Cover/
   - Import textures to Assets/Textures/
   - Import audio to Assets/Audio/

TIP: Start by implementing the Grid System first, as all other systems
     depend on it. Each script has TODO comments marking implementation points.
""")
	print("=" * 80)
	print("Bootstrap complete! Happy coding! 🎮")
	print("=" * 80)

## ============================================================================
## SCRIPT TEMPLATES
## ============================================================================

func get_grid_manager_template() -> String:
	return """class_name GridManager
extends Node

## Manages the tactical grid system
##
## This singleton handles grid creation, cell management, and coordinate conversions.
## It serves as the central authority for all grid-related operations.

signal grid_created(size: Vector2i)
signal cell_selected(cell: GridCell)
signal cell_hovered(cell: GridCell)

@export var grid_size := Vector2i(10, 10)
@export var cell_size := 1.0
@export var grid_height := 0.0

var cells: Dictionary = {}  # Vector2i -> GridCell
var _selected_cell: GridCell = null

func _ready() -> void:
	# TODO: Initialize grid on ready
	pass

## Creates the grid with the specified dimensions
func create_grid(size: Vector2i) -> void:
	# TODO: Implement grid creation
	# - Clear existing cells
	# - Generate new grid cells
	# - Set up cell neighbors
	# - Emit grid_created signal
	pass

## Gets a cell at the specified grid coordinates
func get_cell(coords: Vector2i) -> GridCell:
	# TODO: Return cell from cells dictionary
	return cells.get(coords)

## Converts world position to grid coordinates
func world_to_grid(world_pos: Vector3) -> Vector2i:
	# TODO: Implement world to grid coordinate conversion
	return Vector2i.ZERO

## Converts grid coordinates to world position
func grid_to_world(grid_coords: Vector2i) -> Vector3:
	# TODO: Implement grid to world position conversion
	return Vector3.ZERO

## Highlights cells within movement range
func highlight_movement_range(origin: Vector2i, range: int) -> void:
	# TODO: Implement movement range highlighting
	pass

## Clears all cell highlights
func clear_highlights() -> void:
	# TODO: Clear all cell visual states
	pass

## Selects a cell
func select_cell(cell: GridCell) -> void:
	if _selected_cell:
		_selected_cell.deselect()
	_selected_cell = cell
	if cell:
		cell.select()
		cell_selected.emit(cell)
"""

func get_grid_cell_template() -> String:
	return """class_name GridCell
extends Node3D

## Represents a single cell in the tactical grid
##
## Handles cell state, visualization, and occupancy tracking.

enum CellState {
	NORMAL,
	HIGHLIGHTED,
	SELECTED,
	BLOCKED,
	COVER_AVAILABLE
}

signal cell_clicked(cell: GridCell)
signal cell_mouse_entered(cell: GridCell)
signal cell_mouse_exited(cell: GridCell)

@export var coordinates := Vector2i.ZERO
@export var is_walkable := true
@export var movement_cost := 1.0
@export var current_state := CellState.NORMAL

var occupant: TacticalUnit = null
var cover_points: Array[CoverPoint] = []
var neighbors: Array[GridCell] = []

func _ready() -> void:
	# TODO: Initialize cell visualization
	pass

## Sets the cell's visual state
func set_state(new_state: CellState) -> void:
	current_state = new_state
	# TODO: Update visual representation based on state
	pass

## Checks if this cell can be occupied
func can_occupy() -> bool:
	return is_walkable and occupant == null

## Places a unit on this cell
func occupy(unit: TacticalUnit) -> void:
	# TODO: Set occupant and update unit position
	occupant = unit

## Removes the occupant from this cell
func vacate() -> void:
	# TODO: Clear occupant
	occupant = null

## Selects this cell
func select() -> void:
	set_state(CellState.SELECTED)

## Deselects this cell
func deselect() -> void:
	set_state(CellState.NORMAL)

## Gets the best cover point relative to a threat position
func get_best_cover(threat_position: Vector3) -> CoverPoint:
	# TODO: Evaluate cover points and return best option
	return null
"""

func get_movement_system_template() -> String:
	return """class_name MovementSystem
extends Node

## Handles unit movement and path execution
##
## Manages movement animations, path following, and movement validation.

signal movement_started(unit: TacticalUnit)
signal movement_completed(unit: TacticalUnit)
signal movement_step(unit: TacticalUnit, cell: GridCell)

@export var movement_speed := 5.0
@export var rotation_speed := 10.0

var _moving_units: Dictionary = {}  # TacticalUnit -> MovementData

func _ready() -> void:
	# TODO: Initialize movement system
	pass

func _process(delta: float) -> void:
	# TODO: Update all moving units
	for unit in _moving_units.keys():
		_update_unit_movement(unit, delta)

## Moves a unit along the specified path
func move_unit(unit: TacticalUnit, path: Array[GridCell]) -> void:
	# TODO: Validate path and start movement
	# - Check if path is valid
	# - Deduct action points
	# - Begin movement animation
	pass

## Updates a single unit's movement
func _update_unit_movement(unit: TacticalUnit, delta: float) -> void:
	# TODO: Implement smooth movement along path
	# - Lerp position to next waypoint
	# - Rotate toward movement direction
	# - Advance to next cell when reached
	pass

## Checks if a unit can reach the target cell
func can_reach(unit: TacticalUnit, target: GridCell) -> bool:
	# TODO: Validate movement possibility
	return false

## Calculates movement cost for a path
func calculate_movement_cost(path: Array[GridCell]) -> float:
	# TODO: Sum up movement costs along path
	return 0.0
"""

func get_pathfinding_template() -> String:
	return """class_name Pathfinding
extends Node

## Implements pathfinding algorithms for tactical movement
##
## Uses A* algorithm to find optimal paths considering movement costs and obstacles.

class PathNode:
	var cell: GridCell
	var g_cost: float = 0.0  # Cost from start
	var h_cost: float = 0.0  # Heuristic to goal
	var f_cost: float = 0.0  # Total cost
	var parent: PathNode = null

	func _init(p_cell: GridCell) -> void:
		cell = p_cell

	func calculate_f_cost() -> void:
		f_cost = g_cost + h_cost

## Finds a path from start to goal
func find_path(start: GridCell, goal: GridCell, max_cost: float = INF) -> Array[GridCell]:
	# TODO: Implement A* pathfinding
	# - Initialize open and closed sets
	# - Process nodes by f_cost
	# - Reconstruct path from goal to start
	# - Return reversed path
	return []

## Calculates heuristic distance between two cells
func heuristic(from: GridCell, to: GridCell) -> float:
	# TODO: Implement Manhattan or Euclidean distance
	var dx := abs(to.coordinates.x - from.coordinates.x)
	var dy := abs(to.coordinates.y - from.coordinates.y)
	return float(dx + dy)

## Gets all cells within movement range
func get_reachable_cells(start: GridCell, max_cost: float) -> Array[GridCell]:
	# TODO: Implement flood-fill to find all reachable cells
	# - Use Dijkstra's algorithm variant
	# - Respect movement costs
	# - Return array of reachable cells
	return []

## Reconstructs path from pathfinding nodes
func _reconstruct_path(end_node: PathNode) -> Array[GridCell]:
	var path: Array[GridCell] = []
	var current := end_node
	while current:
		path.push_front(current.cell)
		current = current.parent
	return path
"""

func get_combat_system_template() -> String:
	return """class_name CombatSystem
extends Node

## Manages combat calculations and attack execution
##
## This singleton handles all combat-related operations including
## hit chance calculation, damage resolution, and attack animations.

signal attack_started(attacker: TacticalUnit, target: TacticalUnit)
signal attack_hit(attacker: TacticalUnit, target: TacticalUnit, damage: int)
signal attack_missed(attacker: TacticalUnit, target: TacticalUnit)
signal attack_completed(attacker: TacticalUnit, target: TacticalUnit)

@export var base_hit_chance := 0.75
@export var critical_chance := 0.1
@export var critical_multiplier := 2.0

func _ready() -> void:
	# TODO: Initialize combat system
	pass

## Executes an attack from attacker to target
func execute_attack(attacker: TacticalUnit, target: TacticalUnit) -> void:
	# TODO: Implement attack execution
	# - Calculate hit chance
	# - Roll for hit/miss
	# - Calculate damage
	# - Apply damage to target
	# - Emit appropriate signals
	# - Play attack animation
	attack_started.emit(attacker, target)

## Calculates hit chance for an attack
func calculate_hit_chance(attacker: TacticalUnit, target: TacticalUnit) -> float:
	# TODO: Factor in:
	# - Base accuracy
	# - Distance to target
	# - Cover bonuses
	# - Attacker/target stats
	return base_hit_chance

## Checks if an attack hits
func roll_to_hit(hit_chance: float) -> bool:
	# TODO: Random roll against hit chance
	return randf() < hit_chance

## Checks if target is in range
func is_in_range(attacker: TacticalUnit, target: TacticalUnit) -> bool:
	# TODO: Check if target is within weapon range
	return false

## Gets all valid targets for a unit
func get_valid_targets(attacker: TacticalUnit) -> Array[TacticalUnit]:
	# TODO: Find all enemies within range with line of sight
	return []
"""

func get_damage_calculator_template() -> String:
	return """class_name DamageCalculator
extends Node

## Calculates damage values for combat
##
## Handles damage calculation with armor, resistance, and critical hits.

@export var armor_reduction_factor := 0.5

## Calculates final damage after all modifiers
static func calculate_damage(
	base_damage: int,
	armor: int,
	is_critical: bool = false,
	damage_multiplier: float = 1.0
) -> int:
	# TODO: Implement damage calculation
	# - Apply base damage
	# - Reduce by armor
	# - Apply critical multiplier if critical
	# - Apply any damage multipliers
	# - Return final damage (minimum 1)
	return 0

## Calculates armor damage reduction
static func calculate_armor_reduction(damage: int, armor: int) -> int:
	# TODO: Calculate how much armor reduces damage
	return 0

## Rolls for critical hit
static func roll_critical(crit_chance: float) -> bool:
	return randf() < crit_chance

## Calculates damage falloff with distance
static func calculate_distance_falloff(base_damage: int, distance: float, max_range: float) -> int:
	# TODO: Reduce damage based on distance
	return base_damage
"""

func get_cover_system_template() -> String:
	return """class_name CoverSystem
extends Node

## Manages cover mechanics and cover point tracking
##
## Handles cover detection, cover bonuses, and line of sight calculations.

enum CoverType {
	NONE,
	HALF,
	FULL
}

signal cover_entered(unit: TacticalUnit, cover: CoverPoint)
signal cover_exited(unit: TacticalUnit, cover: CoverPoint)

@export var half_cover_defense_bonus := 20
@export var full_cover_defense_bonus := 40

func _ready() -> void:
	# TODO: Initialize cover system
	pass

## Gets the cover type a unit has against an attacker
func get_cover_type(defender: TacticalUnit, attacker_position: Vector3) -> CoverType:
	# TODO: Determine cover type based on:
	# - Defender's position
	# - Nearby cover points
	# - Attacker's position
	# - Line of sight angle
	return CoverType.NONE

## Calculates the defense bonus from cover
func get_cover_bonus(cover_type: CoverType) -> int:
	match cover_type:
		CoverType.HALF:
			return half_cover_defense_bonus
		CoverType.FULL:
			return full_cover_defense_bonus
		_:
			return 0

## Finds the best cover point for a position relative to a threat
func find_best_cover(position: Vector3, threat_position: Vector3, search_radius: float = 5.0) -> CoverPoint:
	# TODO: Search for nearby cover points
	# - Find cover points within radius
	# - Evaluate cover effectiveness
	# - Return best option
	return null

## Checks if there's a clear line of sight between two positions
func has_line_of_sight(from: Vector3, to: Vector3) -> bool:
	# TODO: Raycast to check for obstructions
	return true
"""

func get_cover_point_template() -> String:
	return """class_name CoverPoint
extends Node3D

## Represents a cover position in the tactical environment
##
## Defines cover type and provides cover bonuses to units.

@export var cover_type: CoverSystem.CoverType = CoverSystem.CoverType.HALF
@export var cover_direction := Vector3.FORWARD
@export var cover_arc := 90.0  # Degrees of protection

var _occupying_unit: TacticalUnit = null

func _ready() -> void:
	# TODO: Initialize cover point visualization
	pass

## Checks if this cover is effective against a threat from the given direction
func provides_cover_against(threat_direction: Vector3) -> bool:
	# TODO: Calculate if threat is within cover arc
	var angle := cover_direction.angle_to(threat_direction)
	return rad_to_deg(angle) <= cover_arc / 2.0

## Occupies this cover point
func occupy(unit: TacticalUnit) -> void:
	_occupying_unit = unit

## Vacates this cover point
func vacate() -> void:
	_occupying_unit = null

## Checks if this cover point is available
func is_available() -> bool:
	return _occupying_unit == null
"""

func get_tactical_unit_template() -> String:
	return """class_name TacticalUnit
extends CharacterBody3D

## Represents a tactical unit on the battlefield
##
## Handles unit state, stats, and actions during tactical combat.

signal health_changed(new_health: int, max_health: int)
signal action_points_changed(new_ap: int, max_ap: int)
signal unit_died(unit: TacticalUnit)
signal action_performed(action_type: String)

@export var unit_name := "Unit"
@export var stats: UnitStats
@export var team_id := 0

var current_health: int = 100
var action_points: int = 2
var current_cell: GridCell = null
var is_active := false

func _ready() -> void:
	# TODO: Initialize unit
	# - Load stats from resource
	# - Set initial health and AP
	# - Initialize visuals
	if stats:
		current_health = stats.max_health
		action_points = stats.max_action_points

## Takes damage and updates health
func take_damage(damage: int) -> void:
	current_health = max(0, current_health - damage)
	health_changed.emit(current_health, stats.max_health)

	if current_health <= 0:
		die()

## Heals the unit
func heal(amount: int) -> void:
	current_health = min(stats.max_health, current_health + amount)
	health_changed.emit(current_health, stats.max_health)

## Spends action points
func spend_action_points(cost: int) -> bool:
	if action_points >= cost:
		action_points -= cost
		action_points_changed.emit(action_points, stats.max_action_points)
		return true
	return false

## Refreshes action points at turn start
func refresh_action_points() -> void:
	action_points = stats.max_action_points
	action_points_changed.emit(action_points, stats.max_action_points)

## Activates this unit for their turn
func activate() -> void:
	is_active = true
	refresh_action_points()

## Deactivates this unit
func deactivate() -> void:
	is_active = false

## Handles unit death
func die() -> void:
	# TODO: Play death animation
	# - Emit unit_died signal
	# - Remove from grid
	# - Disable collision
	unit_died.emit(self)
	queue_free()

## Checks if unit can perform an action
func can_act() -> bool:
	return is_active and action_points > 0 and current_health > 0
"""

func get_unit_stats_template() -> String:
	return """class_name UnitStats
extends Resource

## Defines the statistics for a tactical unit
##
## This resource stores all base stats for units including
## health, movement, accuracy, and combat attributes.

@export_group("Identity")
@export var unit_name := "Soldier"
@export_multiline var description := ""

@export_group("Health")
@export var max_health := 100
@export var armor := 0
@export var shield := 0

@export_group("Action")
@export var max_action_points := 2
@export var movement_range := 5

@export_group("Combat")
@export var base_accuracy := 75
@export var critical_chance := 10
@export var defense := 0

@export_group("Attributes")
@export var strength := 10
@export var agility := 10
@export var intelligence := 10

## Creates a duplicate of these stats
func duplicate_stats() -> UnitStats:
	var new_stats := UnitStats.new()
	new_stats.unit_name = unit_name
	new_stats.description = description
	new_stats.max_health = max_health
	new_stats.armor = armor
	new_stats.shield = shield
	new_stats.max_action_points = max_action_points
	new_stats.movement_range = movement_range
	new_stats.base_accuracy = base_accuracy
	new_stats.critical_chance = critical_chance
	new_stats.defense = defense
	new_stats.strength = strength
	new_stats.agility = agility
	new_stats.intelligence = intelligence
	return new_stats
"""

func get_turn_manager_template() -> String:
	return """class_name TurnManager
extends Node

## Manages turn order and turn-based gameplay
##
## This singleton controls initiative, turn progression, and phase management.

signal turn_started(unit: TacticalUnit)
signal turn_ended(unit: TacticalUnit)
signal round_started(round_number: int)
signal round_ended(round_number: int)
signal combat_ended(winning_team: int)

enum Phase {
	PLANNING,
	EXECUTION,
	ENEMY_TURN,
	RESOLUTION
}

@export var current_phase := Phase.PLANNING

var all_units: Array[TacticalUnit] = []
var active_units: Array[TacticalUnit] = []
var current_unit: TacticalUnit = null
var current_round := 0
var turn_index := 0

func _ready() -> void:
	# TODO: Initialize turn manager
	pass

## Registers a unit for turn management
func register_unit(unit: TacticalUnit) -> void:
	if unit not in all_units:
		all_units.append(unit)
		unit.unit_died.connect(_on_unit_died)

## Unregisters a unit
func unregister_unit(unit: TacticalUnit) -> void:
	all_units.erase(unit)
	active_units.erase(unit)

## Starts a new combat encounter
func start_combat() -> void:
	# TODO: Initialize combat
	# - Sort units by initiative
	# - Start first round
	current_round = 1
	_sort_units_by_initiative()
	start_round()

## Starts a new round
func start_round() -> void:
	active_units = all_units.duplicate()
	turn_index = 0
	round_started.emit(current_round)
	next_turn()

## Advances to the next unit's turn
func next_turn() -> void:
	if turn_index >= active_units.size():
		end_round()
		return

	if current_unit:
		current_unit.deactivate()
		turn_ended.emit(current_unit)

	current_unit = active_units[turn_index]
	current_unit.activate()
	turn_index += 1
	turn_started.emit(current_unit)

## Ends the current round
func end_round() -> void:
	round_ended.emit(current_round)
	current_round += 1

	if _check_combat_end():
		return

	start_round()

## Checks if combat should end
func _check_combat_end() -> bool:
	# TODO: Check win/loss conditions
	# - Check if any team is eliminated
	# - Emit combat_ended if finished
	return false

## Sorts units by initiative
func _sort_units_by_initiative() -> void:
	# TODO: Sort by initiative stat (higher goes first)
	all_units.sort_custom(func(a, b): return a.stats.agility > b.stats.agility)

## Called when a unit dies
func _on_unit_died(unit: TacticalUnit) -> void:
	unregister_unit(unit)
"""

func get_action_queue_template() -> String:
	return """class_name ActionQueue
extends Node

## Manages queued actions for units
##
## Handles action scheduling, validation, and execution order.

class QueuedAction:
	var unit: TacticalUnit
	var action_type: String
	var target: Variant
	var cost: int

	func _init(p_unit: TacticalUnit, p_type: String, p_target: Variant, p_cost: int) -> void:
		unit = p_unit
		action_type = p_type
		target = p_target
		cost = p_cost

signal action_queued(action: QueuedAction)
signal action_executed(action: QueuedAction)
signal queue_cleared()

var action_queue: Array[QueuedAction] = []

## Queues an action for execution
func queue_action(unit: TacticalUnit, action_type: String, target: Variant, cost: int) -> bool:
	# TODO: Validate and queue action
	# - Check if unit can afford action
	# - Add to queue
	# - Emit signal
	if not unit.can_act():
		return false

	var action := QueuedAction.new(unit, action_type, target, cost)
	action_queue.append(action)
	action_queued.emit(action)
	return true

## Executes the next action in the queue
func execute_next() -> void:
	if action_queue.is_empty():
		return

	var action := action_queue.pop_front()
	_execute_action(action)

## Executes all queued actions
func execute_all() -> void:
	while not action_queue.is_empty():
		execute_next()

## Clears the action queue
func clear_queue() -> void:
	action_queue.clear()
	queue_cleared.emit()

## Executes a specific action
func _execute_action(action: QueuedAction) -> void:
	# TODO: Execute based on action_type
	# - Move, Attack, Use Item, etc.
	action_executed.emit(action)
"""

func get_tactical_camera_template() -> String:
	return """class_name TacticalCamera
extends Camera3D

## Tactical camera controller with RTS-style movement
##
## Handles camera movement, rotation, and zoom for tactical view.

signal camera_moved(new_position: Vector3)
signal camera_rotated(new_rotation: Vector3)

@export_group("Movement")
@export var move_speed := 10.0
@export var edge_pan_margin := 20.0
@export var keyboard_pan_speed := 8.0

@export_group("Rotation")
@export var rotation_speed := 2.0
@export var allow_free_rotation := true

@export_group("Zoom")
@export var zoom_speed := 5.0
@export var min_zoom := 5.0
@export var max_zoom := 30.0

@export_group("Bounds")
@export var use_bounds := true
@export var bounds_min := Vector3(-50, 0, -50)
@export var bounds_max := Vector3(50, 0, 50)

var _current_zoom := 15.0
var _target_position := Vector3.ZERO

func _ready() -> void:
	_target_position = global_position

func _process(delta: float) -> void:
	_handle_keyboard_input(delta)
	_handle_mouse_input(delta)
	_update_camera_position(delta)

func _handle_keyboard_input(delta: float) -> void:
	# TODO: Handle WASD or arrow key movement
	var input_dir := Vector3.ZERO

	if Input.is_action_pressed("ui_up"):
		input_dir.z -= 1
	if Input.is_action_pressed("ui_down"):
		input_dir.z += 1
	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1

	if input_dir != Vector3.ZERO:
		move_camera(input_dir.normalized() * keyboard_pan_speed * delta)

func _handle_mouse_input(delta: float) -> void:
	# TODO: Handle edge panning and middle mouse drag
	pass

func _input(event: InputEvent) -> void:
	# TODO: Handle mouse wheel zoom
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_camera(-zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_camera(zoom_speed)

## Moves the camera by the given offset
func move_camera(offset: Vector3) -> void:
	_target_position += offset
	_apply_bounds()

## Zooms the camera
func zoom_camera(zoom_delta: float) -> void:
	# TODO: Adjust camera height/distance
	_current_zoom = clamp(_current_zoom + zoom_delta, min_zoom, max_zoom)

## Focuses the camera on a specific position
func focus_on(target: Vector3) -> void:
	_target_position = target
	_apply_bounds()

## Applies movement bounds
func _apply_bounds() -> void:
	if use_bounds:
		_target_position.x = clamp(_target_position.x, bounds_min.x, bounds_max.x)
		_target_position.z = clamp(_target_position.z, bounds_min.z, bounds_max.z)

## Updates camera position smoothly
func _update_camera_position(delta: float) -> void:
	global_position = global_position.lerp(_target_position, move_speed * delta)
"""

func get_ui_manager_template() -> String:
	return """class_name UIManager
extends Node

## Manages all UI elements in the tactical game
##
## This singleton coordinates UI panels, HUD updates, and user interactions.

signal ui_action_requested(action: String, data: Dictionary)

@export var action_panel: ActionPanel
@export var unit_info_panel: Control
@export var turn_indicator: Label

var _selected_unit: TacticalUnit = null

func _ready() -> void:
	# TODO: Initialize UI connections
	# - Connect to TurnManager signals
	# - Connect to GridManager signals
	# - Set up UI panels
	pass

## Updates the HUD when a unit is selected
func show_unit_info(unit: TacticalUnit) -> void:
	_selected_unit = unit
	# TODO: Update unit info panel
	# - Show health, AP, stats
	# - Update action panel buttons
	if action_panel:
		action_panel.set_unit(unit)

## Hides unit information
func hide_unit_info() -> void:
	_selected_unit = null
	# TODO: Hide panels

## Updates the turn indicator
func update_turn_indicator(unit: TacticalUnit, round: int) -> void:
	if turn_indicator:
		turn_indicator.text = "Round %d - %s's Turn" % [round, unit.unit_name]

## Shows a notification message
func show_notification(message: String, duration: float = 2.0) -> void:
	# TODO: Display temporary notification
	pass

## Shows combat feedback
func show_combat_result(attacker: TacticalUnit, target: TacticalUnit, damage: int, hit: bool) -> void:
	# TODO: Display combat result
	# - Damage numbers
	# - Hit/miss indicator
	# - Screen effects
	pass
"""

func get_action_panel_template() -> String:
	return """class_name ActionPanel
extends PanelContainer

## UI panel for unit action buttons
##
## Displays and handles unit action buttons (Move, Attack, Wait, etc.)

signal action_button_pressed(action: String)

@export var move_button: Button
@export var attack_button: Button
@export var wait_button: Button
@export var ability_container: Container

var _current_unit: TacticalUnit = null

func _ready() -> void:
	# TODO: Connect button signals
	if move_button:
		move_button.pressed.connect(_on_move_pressed)
	if attack_button:
		attack_button.pressed.connect(_on_attack_pressed)
	if wait_button:
		wait_button.pressed.connect(_on_wait_pressed)

## Sets the unit for this action panel
func set_unit(unit: TacticalUnit) -> void:
	_current_unit = unit
	_update_buttons()

## Updates button states based on unit
func _update_buttons() -> void:
	if not _current_unit:
		_disable_all_buttons()
		return

	# TODO: Enable/disable buttons based on:
	# - Action points available
	# - Valid targets in range
	# - Unit state

## Disables all action buttons
func _disable_all_buttons() -> void:
	if move_button:
		move_button.disabled = true
	if attack_button:
		attack_button.disabled = true
	if wait_button:
		wait_button.disabled = true

func _on_move_pressed() -> void:
	action_button_pressed.emit("move")

func _on_attack_pressed() -> void:
	action_button_pressed.emit("attack")

func _on_wait_pressed() -> void:
	action_button_pressed.emit("wait")
"""

func get_audio_manager_template() -> String:
	return """class_name AudioManager
extends Node

## Manages all audio playback
##
## This singleton handles music, sound effects, and audio mixing.

@export_group("Audio Buses")
@export var master_bus := "Master"
@export var music_bus := "Music"
@export var sfx_bus := "SFX"
@export var ui_bus := "UI"

@export_group("Music")
@export var combat_music: AudioStream
@export var menu_music: AudioStream
@export var victory_music: AudioStream

var _music_player: AudioStreamPlayer
var _sfx_players: Array[AudioStreamPlayer] = []
var _sfx_pool_size := 8

func _ready() -> void:
	# TODO: Initialize audio players
	_create_music_player()
	_create_sfx_pool()

## Creates the music player
func _create_music_player() -> void:
	_music_player = AudioStreamPlayer.new()
	_music_player.bus = music_bus
	add_child(_music_player)

## Creates a pool of SFX players
func _create_sfx_pool() -> void:
	for i in _sfx_pool_size:
		var player := AudioStreamPlayer.new()
		player.bus = sfx_bus
		add_child(player)
		_sfx_players.append(player)

## Plays background music
func play_music(stream: AudioStream, fade_duration: float = 1.0) -> void:
	# TODO: Crossfade to new music
	if _music_player.playing:
		# Fade out current, then play new
		pass

	_music_player.stream = stream
	_music_player.play()

## Plays a sound effect
func play_sfx(stream: AudioStream, volume_db: float = 0.0) -> void:
	# TODO: Get available player from pool and play
	var player := _get_available_sfx_player()
	if player:
		player.stream = stream
		player.volume_db = volume_db
		player.play()

## Gets an available SFX player from the pool
func _get_available_sfx_player() -> AudioStreamPlayer:
	for player in _sfx_players:
		if not player.playing:
			return player
	return _sfx_players[0]  # Fallback to first player

## Plays UI sound
func play_ui_sound(stream: AudioStream) -> void:
	# TODO: Play UI feedback sound
	play_sfx(stream)

## Sets master volume
func set_master_volume(volume: float) -> void:
	# TODO: Set bus volume (0.0 to 1.0)
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index(master_bus),
		linear_to_db(volume)
	)
"""

## ============================================================================
## SCENE TEMPLATES
## ============================================================================

func get_test_grid_scene() -> String:
	return """[gd_scene format=3]

[node name="TestGrid" type="Node3D"]

[node name="WorldEnvironment" type="WorldEnvironment" parent="."]

[node name="DirectionalLight3D" type="DirectionalLight3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 0.707107, 0.707107, 0, -0.707107, 0.707107, 0, 10, 0)
shadow_enabled = true

[node name="Camera3D" type="Camera3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 0.707107, 0.707107, 0, -0.707107, 0.707107, 0, 15, 15)
projection = 1
size = 20.0

[node name="GridContainer" type="Node3D" parent="."]

[node name="UnitsContainer" type="Node3D" parent="."]
"""

func get_tactical_unit_scene() -> String:
	return """[gd_scene load_steps=3 format=3]

[ext_resource type="Script" path="res://Framework/Units/tactical_unit.gd" id="1"]

[sub_resource type="CapsuleShape3D" id="1"]
radius = 0.4
height = 1.8

[node name="TacticalUnit" type="CharacterBody3D"]
script = ExtResource("1")

[node name="CollisionShape3D" type="CollisionShape3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.9, 0)
shape = SubResource("1")

[node name="MeshInstance3D" type="MeshInstance3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.9, 0)

[node name="SelectionIndicator" type="MeshInstance3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.05, 0)
visible = false

[node name="HealthBar" type="Node3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0)
"""

func get_low_cover_scene() -> String:
	return """[gd_scene load_steps=3 format=3]

[ext_resource type="Script" path="res://Framework/Cover/cover_point.gd" id="1"]

[sub_resource type="BoxShape3D" id="1"]
size = Vector3(2, 1, 0.3)

[node name="LowCover" type="StaticBody3D"]

[node name="CollisionShape3D" type="CollisionShape3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.5, 0)
shape = SubResource("1")

[node name="MeshInstance3D" type="MeshInstance3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.5, 0)

[node name="CoverPoint" type="Node3D" parent="."]
script = ExtResource("1")
"""

func get_high_cover_scene() -> String:
	return """[gd_scene load_steps=3 format=3]

[ext_resource type="Script" path="res://Framework/Cover/cover_point.gd" id="1"]

[sub_resource type="BoxShape3D" id="1"]
size = Vector3(2, 2, 0.3)

[node name="HighCover" type="StaticBody3D"]

[node name="CollisionShape3D" type="CollisionShape3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0)
shape = SubResource("1")

[node name="MeshInstance3D" type="MeshInstance3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0)

[node name="CoverPoint" type="Node3D" parent="."]
script = ExtResource("1")
"""

func get_test_level_scene() -> String:
	return """[gd_scene format=3]

[node name="TestLevel" type="Node3D"]

[node name="WorldEnvironment" type="WorldEnvironment" parent="."]

[node name="DirectionalLight3D" type="DirectionalLight3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 0.5, 0.866025, 0, -0.866025, 0.5, 0, 10, 5)
shadow_enabled = true

[node name="Ground" type="StaticBody3D" parent="."]

[node name="GridManager" type="Node3D" parent="."]

[node name="CoverObjects" type="Node3D" parent="."]

[node name="Units" type="Node3D" parent="."]

[node name="Camera" type="Camera3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 0.707107, 0.707107, 0, -0.707107, 0.707107, 0, 15, 15)
"""

## ============================================================================
## RESOURCE TEMPLATES
## ============================================================================

func get_unit_stats_resource() -> String:
	return """[gd_resource type="Resource" load_steps=2 format=3]

[ext_resource type="Script" path="res://Framework/Units/unit_stats.gd" id="1"]

[resource]
script = ExtResource("1")
unit_name = "Default Soldier"
description = "A standard tactical unit with balanced stats."
max_health = 100
armor = 10
shield = 0
max_action_points = 2
movement_range = 5
base_accuracy = 75
critical_chance = 10
defense = 15
strength = 10
agility = 10
intelligence = 10
"""

func get_weapon_resource() -> String:
	return """[gd_resource type="Resource" format=3]

[resource]
resource_name = "Default Weapon"
"""
