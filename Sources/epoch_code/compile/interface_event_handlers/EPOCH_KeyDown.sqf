private["_dikCode", "_handled"];
_dikCode = _this select 1;
_shift = _this select 2;
_ctrl = _this select 3;
_alt = _this select 4;
_handled = false;

// Developer Debug
// if (_dikCode == 0x24) then {call compile preprocessFileLineNumbers "epoch.sqf";_handled = true;};


if !(alive player) exitWith{ false };

EPOCH_space = false;

if (_dikCode in [0x02,0x03,0x04,0x58,0x57,0x44,0x43,0x42,0x41,0x40,0x3F,0x3E,0x3D,0x3C,0x3B,0x0B,0x0A,0x09,0x08,0x07,0x06,0x05,0x0E]) then {
	_handled = true;
};

// rasie vol
if (_ctrl && _dikCode == 0x0D) then {
	EPOCH_soundLevel = (EPOCH_soundLevel + 0.1) min 1;
	5 fadeSound EPOCH_soundLevel;
	_dt = [format["<t size = '0.8' shadow = '0' color = '#99ffffff'>Internal sound level: %1%2 </t>", EPOCH_soundLevel * 100, "%"], 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext;
};
// lower vol
if (_ctrl && _dikCode == 0x0C) then {
	EPOCH_soundLevel = (EPOCH_soundLevel - 0.1) max 0.1;
	5 fadeSound EPOCH_soundLevel;
	_dt = [format["<t size = '0.8' shadow = '0' color = '#99ffffff'>Internal sound level: %1%2 </t>", EPOCH_soundLevel * 100,"%"], 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext;
};

// ESC default to cancel
if (_dikCode == 0x01) then {

	if !(isNull EPOCH_Target) then {
			deleteVehicle EPOCH_Target;
			_dt = ["<t size = '0.8' shadow = '0' color = '#99ffffff'>Build Canceled</t>", 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext;
	};

	if !(EPOCH_arr_interactedObjs isEqualTo[]) then {

		EPOCH_arr_interactedObjs remoteExec["EPOCH_server_save_vehicles", 2];
		EPOCH_arr_interactedObjs = [];
	};
};

// Debug Monitor
if (_dikCode == EPOCH_keysDebugMon) then {
	EPOCH_debugMode = !EPOCH_debugMode;
	if (EPOCH_debugMode) then {
		_dt = ["<t size = '0.8' shadow = '0' color = '#99ffffff'>Debug Mode Enabled</t>", 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext;
	} else {
		_dt = ["<t size = '0.8' shadow = '0' color = '#99ffffff'>Debug Mode Disabled</t>", 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext;
		hintSilent "";
	};
	_handled = true;
};

// Player only code
if (vehicle player == player) then {

	if (_dikCode == EPOCH_keysBuildMode1) then {
		if (EPOCH_buildMode == 1) then {
			EPOCH_buildMode = 0;
			EPOCH_snapDirection = 0;
			_dt = ["<t size = '0.8' shadow = '0' color = '#99ffffff'>Build Mode Disabled</t>", 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext;
			EPOCH_Target = objNull;
			EPOCH_Z_OFFSET = 0;
			EPOCH_X_OFFSET = 0;
			EPOCH_Y_OFFSET = 5;
			// EPOCH_SURVEY = [];
		}
		else {
			if (EPOCH_playerEnergy > 0) then {
				EPOCH_stabilityTarget = objNull;
				EPOCH_buildMode = 1;
				_dt = ["<t size = '0.8' shadow = '0' color = '#99ffffff'>Build Mode Enabled: Snap alignment</t>", 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext;
				EPOCH_buildDirection = 0;
			}
			else {
				_dt = ["<t size = '0.8' shadow = '0' color = '#99ffffff'>Need Energy</t>", 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext;
			};
		};
		_handled = true;
	};
	if (_dikCode == EPOCH_keysBuildMode2) then {
		if (EPOCH_buildMode == 2) then {
			EPOCH_buildMode = 0;
			EPOCH_snapDirection = 0;
			_dt = ["<t size = '0.8' shadow = '0' color = '#99ffffff'>Build Mode Disabled</t>", 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext;
			EPOCH_Target = objNull;
			// EPOCH_SURVEY = [];
			EPOCH_Z_OFFSET = 0;
			EPOCH_X_OFFSET = 0;
			EPOCH_Y_OFFSET = 5;
		}
		else {
			if (EPOCH_playerEnergy > 0) then {
				EPOCH_stabilityTarget = objNull;
				EPOCH_buildMode = 2;
				_dt = ["<t size = '0.8' shadow = '0' color = '#99ffffff'>Build Mode Enabled: Free</t>", 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext;
				EPOCH_buildDirection = 0;
			}
			else {
				_dt = ["<t size = '0.8' shadow = '0' color = '#99ffffff'>Need Energy</t>", 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext;
			};
		};
		_handled = true;
	};

	// H - holster unholster
	if (_dikCode == EPOCH_keysHolster) then {
		if (player nearObjects["Const_All_Walls_F", 3] isEqualTo[]) then {
			if (currentweapon player != "") then {
				EPOCH_Holstered = currentweapon player;
				player action["switchWeapon", player, player, 100];
			}
			else {
				if (EPOCH_Holstered != "") then {
					player selectWeapon EPOCH_Holstered;
				};
			};
		};
	};

	if (EPOCH_buildMode > 0) then {
		if (_dikCode == EPOCH_keysBuildDir) then {
			EPOCH_snapDirection = EPOCH_snapDirection + 1;
			if (EPOCH_snapDirection > 3) then {
				EPOCH_snapDirection = 0;
				_dt = ["<t size = '0.8' shadow = '0' color = '#99ffffff'>SNAP DIRECTION MODE: 0</t>", 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext;
			}
			else {
				_dt = [format["<t size = '0.8' shadow = '0' color = '#99ffffff'>SNAP DIRECTION MODE: %1</t>", EPOCH_snapDirection], 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext;
			};
			_handled = true;
		};

		if (!_ctrl) then {
			switch (_dikCode) do {
			case EPOCH_keysBuildMovUp: { EPOCH_Z_OFFSET = (EPOCH_Z_OFFSET + 0.1) min 6; _handled = true };
			case EPOCH_keysBuildMovDn: { EPOCH_Z_OFFSET = (EPOCH_Z_OFFSET - 0.1) max - 3; _handled = true };
			case EPOCH_keysBuildMovFwd: { EPOCH_Y_OFFSET = (EPOCH_Y_OFFSET + 0.1) min 5; _handled = true };
			case EPOCH_keysBuildMovBak: { EPOCH_Y_OFFSET = (EPOCH_Y_OFFSET - 0.1) max 2; _handled = true };
			case EPOCH_keysBuildMovL: { EPOCH_X_OFFSET = (EPOCH_X_OFFSET + 0.1) min 5; _handled = true };
			case EPOCH_keysBuildMovR: { EPOCH_X_OFFSET = (EPOCH_X_OFFSET - 0.1) max - 5; _handled = true };
			case EPOCH_keysBuildRotL: { EPOCH_buildDirection = (EPOCH_buildDirection + 1) min 360; EPOCH_space = true; hintsilent str(EPOCH_buildDirection); _handled = true };
			case EPOCH_keysBuildRotR: { EPOCH_buildDirection = (EPOCH_buildDirection - 1) max 0; EPOCH_space = true; hintsilent str(EPOCH_buildDirection); _handled = true };
			case EPOCH_keysBuildIt: { cursorTarget call EPOCH_fnc_SelectTarget; _handled = true };
			};
		};
	};

	if (_dikCode == EPOCH_keysAcceptTrade) then {
		if (_ctrl) then {
			if (!isNull cursorTarget) then {
				if ((player distance cursorTarget) < 6) then {
					if (cursorTarget != player && isPlayer cursorTarget && vehicle cursorTarget == cursorTarget) then {
						[cursorTarget, player, Epoch_personalToken] call EPOCH_startTRADEREQ;
					};
				};
			};
		} else {
			if !(isNull EPOCH_pendingP2ptradeTarget && isPlayer EPOCH_pendingP2ptradeTarget) then {
				if ((player distance EPOCH_pendingP2ptradeTarget) < 6) then {
					EPOCH_p2ptradeTarget = EPOCH_pendingP2ptradeTarget;
					call EPOCH_startTrade;
				};
			};
		};
		_handled = true;
	};

	if (_dikCode in(actionKeys "moveFastForward") || _dikCode in(actionKeys "moveForward")) then {
		if ((diag_tickTime - EPOCH_lastAGTime) > 1) then {
			EPOCH_lastAGTime = diag_tickTime;
			if !(player nearObjects["Const_All_Walls_F", 6] isEqualTo[]) then {
				_currentPos = player modelToWorld[0, 1, 1];
				if !(surfaceIsWater _currentPos) then {
					_currentPos = ATLtoASL _currentPos;
				};
				player forceWalk(lineIntersects[eyePos player, _currentPos, player, objNull]);
			};
		};
	};

	if ((_dikCode in(actionKeys "moveDown") || _dikCode in(actionKeys "Prone")) && speed player > 0) then {
		_currentPos = player modelToWorld[0, 5, 0.5];
		if !(surfaceIsWater _currentPos) then {
			_currentPos = ATLtoASL _currentPos;
		};
		_handled = (lineIntersects[eyePos player, _currentPos, player, objNull]);
	};

	if (!_ctrl && _dikCode in(actionKeys "GetOver")) then {
		if ((diag_tickTime - EPOCH_lastJumptime) > 2) then {

			_currentPos = player modelToWorld[0, 2, 1];
			if !(surfaceIsWater _currentPos) then {
				_currentPos = ATLtoASL _currentPos;
			};

			if !(lineIntersects[eyePos player, _currentPos, player, objNull]) then {
				EPOCH_lastJumptime = diag_tickTime;
				if (isTouchingGround player && speed player > 10) then {
					if ((primaryWeapon player != "") && (currentWeapon player == primaryWeapon player)) then {
						player switchMove "AovrPercMrunSrasWrflDf";
						EPOCH_switchMove_PVS = [player, 1, Epoch_personalToken];
						publicVariableServer "EPOCH_switchMove_PVS";
						_handled = true;
					} else {
						if (currentWeapon player == "") then {
							player switchMove "epoch_unarmed_jump";
							EPOCH_switchMove_PVS = [player, 2, Epoch_personalToken];
							publicVariableServer "EPOCH_switchMove_PVS";
							_handled = true;
						};
					};
				};
			} else {
				_handled = true;
			};
		} else {
			_handled = true;
		};
	};

	if (_dikCode in(actionKeys "Gear")) then {
		if !(isNull EPOCH_Target) then {
				deleteVehicle EPOCH_Target;
				_dt = ["<t size = '0.8' shadow = '0' color = '#99ffffff'>Build Canceled</t>", 0, 1, 5, 2, 0, 1] spawn bis_fnc_dynamictext;
		};
		if (isTouchingGround player) then {
			_handled = call EPOCH_lootTrash;
		};
		if !(_handled) then {
			if (!isNull(findDisplay 602)) then { //Inventory Open?
				(findDisplay 602) closeDisplay 3000;
			}
			else {
				_handled = _ctrl call EPOCH_startInteract;
			};
		};
	};

}; // end player only code

if (_dikCode in (actionKeys "Salute")) then {
	if (_ctrl) then {
		player playactionNow "GestureFinger";
		_handled = true;
	};
};
if (_dikCode in (actionKeys "TacticalView")) then {
	_handled = true;
};
if (_dikCode in (actionKeys "NightVision")) then {
	if (EPOCH_playerEnergy == 0) then {
		_handled = true;
	};
};

_handled
