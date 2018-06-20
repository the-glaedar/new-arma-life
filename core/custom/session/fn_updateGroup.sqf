#include "..\..\..\script_macros.hpp"
/*
  File: fn_updateOpfor.sqf
  Author: Glaedar

  Description:
  Like updatePartial but for all things opfor
*/
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log " //						  	  		 	Script created by Glaedar @ newarma.life  	        	   						 	  // ";
diag_log " //	 			  			Do not use without the express written permission of the author			  		 	    // ";
diag_log " //	   			  								     admin@newarma.life        	                   									// ";
diag_log " /////////////////////////////////////////////////////////////////////////////////////////////////// ";
diag_log "::New Arma:: Function updateOpfor called.";
private ["_mode","_packet"];
_mode = param [0,0,[0]];
_packet = [getPlayerUID player,playerSide,nil,_mode];

switch (_mode) do {
  case 0: {
    _packet set[2,group player];
  };
};

_packet remoteExecCall ["DB_fnc_updateGroup",RSERV];
