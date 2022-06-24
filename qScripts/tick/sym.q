leftEngineActuate:([]
  timestamp:`timestamp$();
  l_elevon:`int$();
  r_elevon:`int$();
  v_nozzle:`int$();
  h_nozzle:`int$();
  edf:`int$()
  );

leftEngineSense:([]
  timestamp:`timestamp$();
  height:`int$();
  ax:`float$();
  ay:`float$();
  az:`float$();
  gx:`float$();
  gy:`float$();
  gz:`float$()
  );

rightEngineSense:leftEngineSense;
rightEngineActuate:leftEngineActuate;

computeActuate:([]
  timestamp:`timestamp$();
  l_elevon:`int$();
  r_elevon:`int$()
  );

computeSense:([]
  timestamp:`timestamp$();
  height:`int$();
  ax:`float$();
  ay:`float$();
  az:`float$();
  gx:`float$();
  gy:`float$();
  gz:`float$()
  );