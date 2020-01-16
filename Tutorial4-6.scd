
/*==========================
SuperCollider Tutorial4-6 Basic
============================*/
// shift + return = run single line
// cmd + return = run in ( ... )

//Envelopes and doneAction------------------------------
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

Env.new([0, 1, 0.2, 0.01], [0.5, 1, 2], \exp).plot;
Env.new([0, 1, 0.2, 0.01], [0.5, 1, 2], [3, -3, 0]).plot; // postive slowly first and then quickly neg in the other hand

// apply the Env.new to the function
(
{
    var sig, env;
    env = EnvGen.kr(Env.new(
    [0, 1, 0.2, 0.01], 
    [0.5, 1, 2], 
    [3, -3, 0])
    doneAction:2);
    sig = Pluse.ar(ExpRand(30,500)) * env;
}.play;
)

(
x = {
    //arg t_gate = 0;
    arg t_gate = 0;
    var sig, env;
    env = EnvGen.kr(Env.new(
    [0, 1, 0.2, 0.01], 
    [0.5, 1, 2], 
    [3, -3, 0])
    doneAction:2);
    sig = Pluse.ar(LFPulse.kr(8).range(600,900)) *env;
}.play;
)
// to turn on the sound; 
//x.set(\gate,1);
x.set(\t_gate,1);      


