% amplify the EMG signal.

function struct_data = add_gain(struct_data, current)

gainValue = current.ap.amp.gain;
struct_data.signals.MES.sig = gainValue .* struct_data.signals.MES.sig;
