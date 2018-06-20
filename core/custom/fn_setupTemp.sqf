#include "..\..\script_macros.hpp"
/*
  Author: Glaedar
  File: fn_setupTemp.sqf

  Description:
  Caches the current database levels so that said levels can be used in-game.
*/
diag_log "::New Arma:: Setting up temporary levels";

life_guild_temp = (FETCH_CONST(life_guild));
life_ocrime_temp = (FETCH_CONST(life_ocrime));
life_gcrime_temp = (FETCH_CONST(life_gcrime));
life_vcrime_temp = (FETCH_CONST(life_vcrime));
life_taxi_temp = (FETCH_CONST(life_taxi));
life_delivery_temp = (FETCH_CONST(life_delivery));
life_processing_temp = (FETCH_CONST(life_processing));
life_gathering_temp = (FETCH_CONST(life_gathering));
life_civRep_temp = (FETCH_CONST(life_civRep));
life_copRep_temp = (FETCH_CONST(life_copRep));
life_indepRep_temp = (FETCH_CONST(life_indepRep));
life_opforRep_temp = (FETCH_CONST(life_opforRep));
