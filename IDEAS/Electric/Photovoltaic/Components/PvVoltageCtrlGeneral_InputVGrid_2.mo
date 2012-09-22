within IDEAS.Electric.Photovoltaic.Components;
model PvVoltageCtrlGeneral_InputVGrid_2
  "Basic controller, with fixed shut down time, with RealInput for grid voltage"

extends Modelica.Blocks.Interfaces.BlockIcon;

parameter Real VMax = 248;
parameter Real timeOff = 300;
parameter Integer numPha=1
    "1 or 3, just indicates if it's a single or 3 phase PV system";

Boolean switch(start = true, fixed=true) "if true, system is producing";

  Modelica.Blocks.Interfaces.RealInput PInit
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput QInit
    annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
  Modelica.Blocks.Interfaces.RealOutput PFinal
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.RealOutput QFinal
    annotation (Placement(transformation(extent={{90,10},{110,30}})));

protected
  discrete Real restartTime( start=-1, fixed=true)
    "system is off until time>restartTime";

public
  Modelica.Blocks.Interfaces.RealInput VGrid
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
equation

when {VGrid > VMax, time > pre(restartTime)} then
  if VGrid > VMax then
    switch = false;
    restartTime = time + timeOff;
  else
    switch = true;
    restartTime = -1;
  end if;
end when;

if switch then
  PFinal = PInit;
else
  PFinal = 0;
end if;

QFinal = QInit;

  annotation (Diagram(graphics));
end PvVoltageCtrlGeneral_InputVGrid_2;
