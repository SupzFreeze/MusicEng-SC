
/*==========================
SuperCollider Tutorial4-6 Basic
============================*/
// shift + return = run single line
// cmd + return = run in ( ... )

(
x = {
  var sig, freq, env;
  //env = Line.kr(1, 0, 1);
  env = XLine.kr(1, 0.01, 5, doneAction:2); //nicer sounding phase wih XLine
  freq = XLine.kr(880, 110, 1, doneAction:0); // or remove doneAction
  sig = Pulse.ar(ExpaRand(30, 500)) * env;
}.play;
)

0.125.ampdb // check  the DB sound

x.free;

s.freeall; // cmd +  , 


Env.new.plot; // draw plot

(
{
    var sig, env;
    env = EnvGen.kr(Env.new, doneAction:2);
    sig = Pluse.ar(ExpRand(30,500)) * env;
}.play;
)
