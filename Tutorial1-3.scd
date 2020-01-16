g
/*==========================
SuperCollider test01 Basic
============================*/
// shift + return = run single line
// cmd + return = run in ( ... )

recive.massage

3.cubed

x = 3.cubed

//Local Varible
(
var number;
number = 3.cubed;
)

//Goble Variable

~number = 3.cubed;
~number;

// Spreate line would be good than
(
var foo;
foo = 3;
foo = foo.cubed;
foo = foo + 100;
foo = foo / 2;
foo;
)

//Server thing
Server.local.boot;
Server.local.quit;

s.boot;
s.quit;

x = {SinOsc.ar}.play;

x.free;

x = {SinOsc.ar(440, 0, 0.125, 0)}.play;

(
z = {
	arg freq = 440, amp = 1;
	var sig;
	sig = SinOsc.ar(freq) * amp
}.play;
)

z.set(\amp, 0.125);
z.set(\freq, 500);
z.set(\freq, 700, \amp, 0.5);
z.free;
// use more agreement
(
z = {
	arg noiseHz = 8;
	var freq, amp, sig;
	//freq = LFNoise0.kr(8, 400, 600);
	//freq = LFNoise0.kr(8).range(200, 1000);
	freq = LFNoise0.kr(noiseHz).exprange(200, 1000);
	amp = LFNoise1.kr(12).exprange(0.02, 1);
	sig = SinOsc.ar(freq) * amp;
}.play;
)

z.set(\noiseHz,10);
z.set(\noiseHz, exprand(4,64));

// synth and synthDef
(
SynthDef.new(\sineTest, {
	arg noiseHz = 8;
	var freq, amp, sig;
	freq = LFNoise0.kr(noiseHz).exprange(200, 1000);
	amp = LFNoise1.kr(12).exprange(0.02, 1);
	sig = SinOsc.ar(freq) * amp;
	Out.ar(0,sig); // 0 is L speaker, 1 is Right speaker
}).add;
)

x = Synth.new(\sineTestม [\noiseHz, 32]);
x.set(\noiseHz,12);
x.free;

(
SynthDef.new(\pulseTest, {
	arg ampHz=4, fund=40, maxPartial=4, width=0.5;
	var amp1, amp2, freq1, freq2, sig1, sig2;
	amp1 = LFPulse.kr(ampHz, 0, 0.12) * 0.75;
	amp2 = LFPulse.kr(ampHz, 0.5, 0.12) * 0.75;
	freq1 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(fund);
	freq2 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(fund);
	freq1 = freq1 * LFPulse.kr(8, add:1);
	freq2 = freq2 * LFPulse.kr(6, add:1);
	sig1 = Pulse.ar(freq1, width, amp1);
	sig2 = Pulse.ar(freq2, width, amp2);
	sig1 = FreeVerb.ar(sig1, 0.7, 0.8, 0.25);
	sig2 = FreeVerb.ar(sig2, 0.7, 0.8, 0.25);
	Out.ar(0,sig1);
	Out.ar(1,sig2);
}).add;
)

x = Synth.new(\pulseTest);
x.set(\width, 0.25);
x.set(\fund, 80);
x.set(\maxPartial, 20);
x.set(\ampHz, 0.25);
// array setup
x = Synth.new(\pulseTest, [\ampHz, 3.3, \fund, 48, \width, 0.15])

x.free;





