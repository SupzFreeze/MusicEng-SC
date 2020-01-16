
/*==========================
SuperCollider Tutorial4-5 Basic
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
/*  fixed length env ==> doneAction0 and re-trigger by 't_'
    One shot sound with fixed length env ==> doneAction2 */

x.free;


//adsr ==> have subtain 

(
x = {
    arg gate=0;
    var sig, env, freq;
    freq = EnvGen.kr(Env.adsr(1), gate, 200, 0.1)
    env = EnvGen.kr(Env.adsr, gate);
    sig = VarSaw.ar(SinOsc.kr(16).range(500,1000)) * env;
}.play;
)

x.set(\gate,1);
x.set(\gate,0);  // done with 1s. s 

//Multichannel Expansion ------------------------------------

s.meter; //cmd + m , cmd + shift + d ==> search  Multichannel Expansion

x ={SinOsc.ar}.play; // 1 ch.
x ={[SinOsc.ar(300), SinOsc.ar(500)]}.play; // 2 ch.
x ={SinOsc.ar([300, 500])}.play; // same as above

x.free;

(
x = {
    var sig, amp;
    amp = SinOsc.kr([7, 1]).range(0,1);
    sig = SinOsc.ar([300,500]);
    sig = sig * amp;
    //Mix.new(sig) * 0.25; //mix all ch.
    //[Mix.new(sig), Mix.new(sig)] * 0.25;
    //Mix.new(sig).dub(2) * 0.25; // same as above
    //Mix.new(sig)!2 * 0.25; // same as above
    Splay.ar(sig) *0.5; // complex sound 
}.play;
)

x = {PinkNoise.ar(0.5)!2}.play;
x = {PinkNoise.ar(0.5!2)}.play; // unique sound

(
SynthDef.new(\multi, {
    var sig, amp;
    amp = SinOsc.kr([7, 1, 2, 0.2, 6]).range(0,1);
    sig = SinOsc.ar([300,500,700,900,1100]);
    sig = sig * amp;
    sig = Splay.ar(sig) *0.5;
    Out.ar(0, sig); // use lowest number
}).add;
)

x = Synth.new(\multi);
x.free;

rrand(50, 1200)!4; // coppy all will get the same 4 output
{rrand(50, 1200)}!4; // not same output 

(
SynthDef.new(\multi, {
    var sig, amp;
    amp = SinOsc.kr({ExpRand(0.2, 12)}!8).range(0,1); //upper case will not creat the same 
    sig = SinOsc.ar({ExpRand(50,1200)}!8);
    sig = sig * amp;
    sig = Splay.ar(sig) *0.5;
    Out.ar(0, sig); // use lowest number
}).add;
)

( //rich texture sine wave
SynthDef.new(\multi, {
    var sig, amp;
    env = EnvGen.kr(
        Env.new([0,1,0],[10,10],[1,-1]),
        doneAction:2;
    );
    amp = SinOsc.kr({ExpRand(0.2, 12)}!8).range(0,1); //upper case will not creat the same 
    sig = SinOsc.ar({ExpRand(50,1200)}!8);
    sig = sig * amp;
    sig = Splay.ar(sig) *0.5;
    Out.ar(0, sig); // use lowest number
}).add;
)
