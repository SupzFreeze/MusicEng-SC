/*==========================
SuperCollider tut06-tut07 Basic
============================*/
// shift + return = run single line
// cmd + return = run in ( ... )


[1,3,4,5,6].do{"Hello".postln};

// use do for modify the data from the collection
(
[1,3,4,5,6].do{
	arg item;
	item.squared.postln;
};
)

(
x = Array.newClear(5); // not the best
[1,3,4,5,6].do{
	arg item, count;
	x[count] = item.squared;
};
)

s.boot;
x = {VarSaw.ar(40!2, 0, 0.5)}.play;

(
SynthDef.new(\wowsaw, {
	var temp, sum;
	sum = 0;
	10.do{
		temp = VarSaw.ar(
			40 * {Rand(0.99,1.02)}!2,
			{Rand(0.0,0.1)}!2, // avoid clipping
			{ExpRand(0.005,0.5)}!2
		);
		sum = sum + temp;
	};
	sum = sum * 0.05;
	Out.ar(0, sum);
});
)

x = Synth.new(\wowsaw);

// add env


(
SynthDef.new(\wowsaw, {
	arg freq=40;
	var temp, sum, env;
	sum = 0;
	env = EnvGen.kr(
		Env.perc(0.01, 5, 1, -2),
		doneAction:2
	);
	10.do{
		temp = VarSaw.ar(
			freq * {Rand(0.99,1.02)}!2,
			{Rand(0.0,0.1)}!2, // avoid clipping
			{ExpRand(0.005,0.05)}!2;
	);
		sum = sum + temp;
	};
	sum = sum * 0.05 * env;
	Out.ar(0, sum);
}).add;
)


Synth.new(\wowsaw, [\freq, 440]);
Synth.new(\wowsaw, [\freq, 600]);
Synth.new(\wowsaw, [\freq, 700]);
Synth.new(\wowsaw, [\freq, 200]);

Synth.new(\wowsaw, [\freq, 66.midicps]);

s.quit;


// Tut 07

(
SynthDef.new(\blip, {
	arg out;
	var freq, trig, sig;
	freq = LFNoise0.kr(3).exprange(300,1200).round(300);
	sig = SinOsc.ar(freq) * 0.25;
	trig = Dust.kr(2);
	sig = sig * EnvGan.kr(Env.perc(0.01, 0.2), trig);
	sig = Pan2.ar(sig, LFNoise1.kr(10));
	Out.ar(out, sig);
}).add;

SynthDef.new(\reverb, {
	arg in, out=0;
	var sig;
	sig = In.ar(in,1);
	sig = FreeVerb.ar(sig, 0.5, 0.8, 0.2)!2;
	Our.ar(out, sig);
}).add;
)

s.option.numAudioBusChannels;
s.option.numOutputBusChannels;
s.option.numInputBusChannels;

s.reboot;
s.meter;

y = Synth.new(\reverb, [\in, 6]);
x = Synth.new(\blip, [\out, 6]);
x.set(\out, 25);
y.set(\in, 25);
x.free;
y.free;

y = Synth.new(\reverb, [\in, ~reverbBus]);
y = Synth.new(\reverb, [\out, ~reverbBus]);
x.free;
y.free;
s.tree;

~reverbBus Bus.audio(s,1);
~reverbBus.index;
~reverbBus2 = Bus.audio(s, 2);

y = SynthDef.new(\reverb, [\in, ~reverbBus2], S, \addToTail);
x = SynthDef.new(\blip, [\out, ~reverBus2], S);

y = SynthDef.new(\reverb, [\in, ~reverbBus2], x, \addAfter); // to add after like that specily add in the effect

s.freeAll;

// or add to ground and order the group collectly
x = SynthDef.new(\blip, [\out, ~reverBus2], ~sourceGrp);
y = SynthDef.new(\reverb, [\in, ~reverbBus2], ~fxGrp);

~sourceGrp = Group.new;
~fxGrp = Group.after(~sourceGrp);


(
SynthDef.new(\blip, {
	arg out, fund=300, dens=2, decay=0.2;
	var freq, trig, sig;
	freq = LFNoise0.kr(3).exprange(fund,fund*4).round(fund);
	sig = SinOsc.ar(freq) * 0.25;
	trig = Dust.kr(dens);
	sig = sig * EnvGan.kr(Env.perc(0.01, decay), trig);
	sig = Pan2.ar(sig, LFNoise1.kr(10));
	Out.ar(out, sig);
}).add;

SynthDef.new(\reverb, {
	arg in, out=0;
	var sig;
	sig = In.ar(in,1);
	sig = FreeVerb.ar(sig, 0.5, 0.8, 0.2)!2;
	Our.ar(out, sig);
}).add;
)

8.do{
	Synth.new(
		\blip.
		[
			\out. ~reverBus2,
			\fund, exprand(60, 300).round(30)
		],
		~sourceGrp
	);
}

// synth group note sever achtech


