private["_sapper","_trader","_cage","_cage2","_cagePos","_sounds","_sound"];
_sapper = _this select 0;
_trader = _this select 1;

_cagePos = (getPosATL _trader) findEmptyPosition [1,50,"Land_Cages_F"];
_cage = createVehicle ["Land_Cages_F", _cagePos, [], 2, "CAN_COLLIDE"] ;
_cage setVectorDirAndUp [[0,0,1],[0,1,0]];
_cage2 = createVehicle ["Land_Cages_F", _cagePos, [], 2, "CAN_COLLIDE"] ;
_cage2 setVectorDirAndUp [[0,0,1],[0,1,0]];
_cage attachTo [_cage2,[0,1.3,0]];

EPOCH_TEMPOBJ_PVS = [_cage,_cage2];
publicVariableServer "EPOCH_TEMPOBJ_PVS";


_startCage = diag_tickTime;
while {_sapper distance _cage > 3 || diag_tickTime - _startCage < 12} do {
	_sapper moveTo _cagePos;
	uiSleep 3;
};

deleteVehicle _sapper;
_sapper = createAgent ["Epoch_Sapper_F", getPos _cage2, [], 0, "FORM"];
_sapper setUnitPos "UP";
_sapper attachTo [_cage2,[0.4,-0.6,-0.4]];
_sapper setVectorDirAndUp [[0,0,1],[0,1,0]];
_sapper forcespeed 0;

if !(isNull _sapper) then {
	EPOCH_TEMPOBJ_PVS = _sapper;
	publicVariableServer "EPOCH_TEMPOBJ_PVS";
};

EPOCH_FillContainer_PVS = [player,Epoch_personalToken,objNull,false,25];
publicVariableServer "EPOCH_FillContainer_PVS";


while {player distance _sapper < 100 && alive player} do {
	if ((random 100) < 0.5) then {
		_sounds = ["sapper_groan0","sapper_groan1","sapper_groan2"];
		_sound = _sounds select (floor (random (count _sounds)));
		_sapper say3D _sound;
		EPOCH_say3D_PVS = [player, _sapper,(EPOCH_sounds find _sound), Epoch_personalToken];
		publicVariableServer "EPOCH_say3D_PVS";
	};
	uiSleep 0.5;
};
