extends Node2D

@onready var missing_install_error_message: Label = $"../Control/MissingInstallErrorMessage"
@onready var corrupt_install_error_message: Label = $"../Control/CorruptInstallErrorMessage"

## Boot into this scene after verification.
var main = preload("res://startup/main.tscn")

const INSTALL_PATH = "C:/Program Files (x86)/Steam/steamapps/common/The Escapists/"

## What the contents of the Escapists installation should look like.
const auth_targets: Dictionary[String, String] = {
	"TheEscapists.exe": "f1cae26d90a5229bf6b3aa45d149ec715577f6798754c9cfb5007f166b8a3816",
	"TheEscapists_eur.exe": "40b3806e1eb0733140b3cd61d0415c6443aa3b8a18f4cde923cf645f05af6cfc",
	"TheEscapists_pol.exe": "455fc1d3e58e85ee967924b358876f0f733f881aeacac19f4389d63fe53da4a6",
	"TheEscapists_rus.exe": "ac527e28f0a7c2044128fdb9d7f296ef645c18133752e6a65c910ce20163c59f",
	"steam_api.dll": "fd16fba7a64afdcfcad2a935337432400c8c528e3f210a6672254f75d39bad7e",
	"Editor/editor_eur.exe": "5654f7b4d7447bbcc9fbcdbfbf64038ad8045cb7dc53a5f2dc8c27248e0920a1",
	"Editor/editor_pol.exe": "3a1cf27576eb19de66db2f5eb8c2be7fbc30fccfb20c0c5bbd890edb583a9d38",
	"Editor/editor_rus.exe": "df5ae01fdb0b5bed53112cf8820e32d678966a66cce6c315eee4e3d934383e93",
	"Editor/steam_api.dll": "fd16fba7a64afdcfcad2a935337432400c8c528e3f210a6672254f75d39bad7e"
}

enum FailReason {
	Missing,
	Corrupt
}

func _ready() -> void:
	# can't remember why this is here but I think it's necessary
	await get_tree().process_frame
	
	if !DirAccess.dir_exists_absolute(INSTALL_PATH):
		print("[Preload] Failed: install is missing.")
		missing_install_error_message.show()
	elif !_is_installation_valid():
		print("[Preload] Failed: install is corrupt.")
		corrupt_install_error_message.show()
	else:
		print("[Preload] Checks passed, proceeding to load.")
		#_proceed_to_game()

func _is_installation_valid() -> bool:
	for target in auth_targets.keys():
		if _hash_file(INSTALL_PATH + target) != auth_targets[target]:
			return false
		print("[Preload] Hash for %s is valid." % target)
	
	return true

func _hash_file(path: String, algorithm := HashingContext.HASH_SHA256) -> String:
	var ctx := HashingContext.new()
	ctx.start(algorithm)

	var f := FileAccess.open(path, FileAccess.READ)
	if not f:
		push_error("Cannot open %s" % path)
		return String()

	while not f.eof_reached():
		ctx.update(f.get_buffer(65536))

	f.close()
	return ctx.finish().hex_encode()
