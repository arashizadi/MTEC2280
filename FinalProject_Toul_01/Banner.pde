void textBanner (byte screen) {
  switch (screen) {
  case 0:
    title = "Main Menu";
    helper = "Active Oscillators: ";
    int i;
    for (i = 0; i < one.outputs.length; i++) {
      lines[0] = false;
      if (one.outputs[i] == true) {
        lines[0] = true;
        break;
      }
    }
    for (i = 0; i < two.outputs.length; i++) {
      lines[1] = false;
      if (two.outputs[i] == true) {
        lines[1] = true;
        break;
      }
    }
    for (i = 0; i < three.outputs.length; i++) {
      lines[2] = false;
      if (three.outputs[i] == true) {
        lines[2] = true;
        break;
      }
    }
    for (i = 0; i < four.outputs.length; i++) {
      lines[3] = false;
      if (four.outputs[i] == true) {
        lines[3] = true;
        break;
      }
    }
    for (i = 0; i < lines.length; i++)
      if (lines[i] == true)
        helper += "Line " + lines[i]+1 + ", ";
    if (helper == "Active Oscillators: ")
      helper = "No Active Oscillators";
    else
      helper = helper.substring(0, helper.length() - 2);
    break;
  case 1:
    break;
  case 2:
    break;
  case 3:
    break;
  case 4:
  case 5:
    helper = "Active Time-Based Effects: ";
    if (_reverbWet != 0)
      revdelStatus[0] = true;
    else
      revdelStatus[0] = false;
    if (_delayFeedback != 0)
      revdelStatus[1] = true;
    else
      revdelStatus[1] = false;
    if (revdelStatus[0])
      helper += "Reverb, ";
    if (revdelStatus[1])
      helper += "Delay, ";
    if (helper == "Active Time-Based Effects: ")
      helper = "No Active Time-Based Effects";
    else
      helper = helper.substring(0, helper.length() - 2);
    break;
  }
  text(helper, width/2, 8 + height - 35 + 35/2);
}
