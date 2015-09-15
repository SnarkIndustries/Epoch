private["_notReady","_abortAfter","_start","_finish","_dirTo","_nrPlyrs","_i","_pos","_trgt","_sapperCount"];
 _disableAI = {
	{_this disableAI _x}forEach["TARGET","AUTOTARGET","FSM"];
};

_trgt = player;
if(count _this > 0)then{
_trgt = _this select 0;
};
_sapperCount = 8;
if(count _this > 1)then{
_sapperCount = _this select 1;
};
_notReady = true;
_abortAfter = 0;
_start = [];
_finish = [];
while {_notReady} do {
_start =  [_trgt, 480, random 360] call BIS_fnc_relPos;
_dirTo = [_start,_trgt,18] call EPOCH_fnc_dirToFuzzy;
_finish =  [_start, ((_start distance _trgt) * 2), _dirTo] call BIS_fnc_relPos;
_nrPlyrs = nearestObjects [_start, ["Epoch_Female_base_F","Epoch_Man_base_F"],200];
	if((!(surfaceIsWater _start) && !(surfaceIsWater _finish) && (count _nrPlyrs < 1)) || _abortAfter > 41)then{
	_notReady = false;
	};
_abortAfter = _abortAfter + 1;
};

if(_abortAfter < 42)then{
	for "_i" from 1 to _sapperCount step 1 do  {
	_pos = _start findEmptyPosition [0,20,"Epoch_Sapper_F"];
	_axeSapper = createAgent ["Epoch_Sapper_F", _pos, [], 12, "FORM"];
	waitUntil {_axeSapper == _axeSapper};
	_axeSapper call _disableAI;
	EPOCHSapperMigrationHandle = [_axeSapper,_finish] execFSM "\x\addons\a3_epoch_code\System\sapperSwarmMember.fsm";
	uiSleep 0.75;
	};
Epoch_axeMigrationRunning = true;
};