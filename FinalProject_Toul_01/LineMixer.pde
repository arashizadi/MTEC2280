class LineMixer {
  boolean muted, adsrBool = true;
  float freq, amp, savedAmp, pan, a, d, s, r, delayTime, delayFeedback, reverbRoom, reverbDamp, reverbWet;
  boolean [] outputs = {false, false, false, false, false, false, false}; //0 = sine, 1 = tri, 2 = sqr, 3 = saw, 4 = white, 5 = pink, 6 = brown;
  int numberOfActiveOutputs = 0, input;
  final SinOsc sin;
  final TriOsc tri;
  final SqrOsc sqr;
  final SawOsc saw;
  final WhiteNoise white;
  final PinkNoise pink;
  final BrownNoise brown;
  final LowPass lp;
  final HighPass hp;
  final Env adsr;
  final Delay delay;
  final Reverb reverb;
  LineMixer(int _input, SinOsc _sin, TriOsc _tri, SqrOsc _sqr, SawOsc _saw, WhiteNoise _white, PinkNoise _pink, BrownNoise _brown, LowPass _lp, HighPass _hp, Env _adsr, Delay _delay, Reverb _reverb) {
    sin = _sin;
    tri = _tri;
    sqr = _sqr;
    saw = _saw;
    white = _white;
    pink = _pink;
    brown = _brown;
    lp = _lp;
    hp = _hp;
    adsr = _adsr;
    delay = _delay;
    reverb = _reverb;
    input = _input;
    pan = _pan[input];
    freq = _freq[input];
    sin.amp(0);
    tri.amp(0);
    sqr.amp(0);
    saw.amp(0);
    white.amp(0);
    pink.amp(0);
    brown.amp(0);
    this.sin.play();
    tri.play();
    sqr.play();
    saw.play();
    white.play();
    pink.play();
    brown.play();
    lp.process(sin);
    lp.process(tri);
    lp.process(sqr);
    lp.process(saw);
    hp.process(sin);
    hp.process(tri);
    hp.process(sqr);
    hp.process(saw);
    delayTime = _delayTime; 
    delayFeedback = _delayFeedback;
    delay.process(sin, 0);
    delay.process(tri, 0);
    delay.process(sqr, 0);
    delay.process(saw, 0);
    reverbRoom = _reverbRoom; 
    reverbDamp = _reverbDamp;
    reverbWet = _reverbWet;
    reverb.process(sin);
    reverb.process(tri);
    reverb.process(sqr);
    reverb.process(saw);
    amp = _amp[input];
    a = _a;
    d = _d;
    s = _s;
    r = _r;
  }
  void play() {
        filters();

    freq();
    amp();
    pan();
    if (adsrBool)
      adsr();
  }
  void play(float _userFreq) {
        filters();
    freq(_userFreq);
    amp();
    pan();
    if (adsrBool)
      adsr();
  }
  void pan() {
    sin.pan(pan);
    tri.pan(pan);
    sqr.pan(pan);
    saw.pan(pan);
  }
  void adsr() {
    adsr.play(sin, a, d, s, r);
    adsr.play(tri, a, d, s, r);
    adsr.play(sqr, a, d, s, r);
    adsr.play(saw, a, d, s, r);
    adsr.play(white, a, d, s, r);
    adsr.play(pink, a, d, s, r);
    adsr.play(brown, a, d, s, r);
  }
  void toggleAdsr() {
    adsrBool = !adsrBool;
  }
  void amp() {
    if (outputs[0])
      sin.amp(amp);
    else
      sin.amp(0);
    if (outputs[1])
      tri.amp(amp);
    else
      tri.amp(0);
    if (outputs[2])
      sqr.amp(amp);
    else
      sqr.amp(0);
    if (outputs[3])
      saw.amp(amp);
    else
      saw.amp(0);
    if (outputs[4])
      white.amp(amp);
    else
      white.amp(0);
    if (outputs[5])
      pink.amp(amp);
    else
      pink.amp(0);
    if (outputs[6])
      brown.amp(amp);
    else
      brown.amp(0);
  }
  void toggleSin() {
    outputs[0] = !outputs[0];
  }
  void toggleTri() {
    outputs[1] = !outputs[1];
  }
  void toggleSqr() {
    outputs[2] = !outputs[2];
  }
  void toggleSaw() {
    outputs[3] = !outputs[3];
  }  
  void toggleWhite() {
    outputs[4] = !outputs[4];
  }
  void togglePink() {
    outputs[5] = !outputs[5];
  }
  void toggleBrown() {
    outputs[6] = !outputs[6];
  }  
  void freq() {
    sin.freq(freq);
    tri.freq(freq);
    sqr.freq(freq);
    saw.freq(freq);
  }
  void freq(float _userFreq) {
    freq = _userFreq;
    sin.freq(freq);
    tri.freq(freq);
    sqr.freq(freq);
    saw.freq(freq);
  }
  void filters() {
    lp.freq(lpf[input]);
    hp.freq(hpf[input]);
    delay.set(delayTime, delayFeedback);
    reverb.set(reverbRoom, reverbDamp, reverbWet);
  }
  void setFreq(float _userFreq) {
    freq = _userFreq + _pitch;
  }
  void mute() {
    savedAmp = amp;
    amp = 0;
    muted = true;
  }
  void unmute() {
    amp = savedAmp;
    muted = false;
  }
  boolean isMuted() {
    return muted;
  }
  void setVolume(float _userAmp) {
    numberOfActiveOutputs = 0;
    for (int i = 0; i < outputs.length; i++)
      if (outputs[i])
        numberOfActiveOutputs++;
    if (_userAmp/(NUMBER_OF_AMPS + numberOfActiveOutputs) <= 1)
      amp = _userAmp/(NUMBER_OF_AMPS + numberOfActiveOutputs);
  }
  void volumeUp() {
    numberOfActiveOutputs = 0;
    for (int i = 0; i < outputs.length; i++)
      if (outputs[i])
        if (amp + 1f < amp/(NUMBER_OF_AMPS + numberOfActiveOutputs))
          amp =+ 1f;
        else
          amp = 1/(NUMBER_OF_AMPS + numberOfActiveOutputs);
  }
  void volumeDown() {
    numberOfActiveOutputs = 0;
    for (int i = 0; i < outputs.length; i++)
      if (outputs[i])
        if (amp - 1f > 0)
          amp =- 1f;
        else
          amp = 0;
  }
  void setPan(float _userPan) {
    if (_userPan <= 1 || _userPan >= -1)
      pan = _userPan;
  }
  void panUp() {
    if (pan + 0.1f < 1)
      pan += 0.1f;
  }
  void panDown() {
    if (pan - 0.1f > -1)
      pan -= 0.1;
  }
  void setLpf(float _userLpf) {
      lpf[input] = _userLpf;
  }
  void setHpf(float _userHpf) {
      hpf[input] = _userHpf;
  }
  String getActiveOuts() {
    String _return = "";  
    for (int i = 0; i < outputs.length; i++)
      if (outputs[i])
        switch (i) {
        case 0:
          _return += "Sine, ";
          break;
        case 1:
          _return += "Triangle, ";
          break;
        case 2:
          _return += "Square, ";
          break;
        case 3:
          _return += "Saw, ";
          break;
        case 4:
          _return += "White, ";
          break;
        case 5:
          _return += "Pink, ";
          break;
        case 6:
          _return += "Brown, ";
          break;
        }
    if (_return != "")
      return _return.substring(0, _return.length() - 2);
    else return "";
  }
}
