regular_scissor = gpu_get_scissor();

var ratio = min(WIN_W/APP_W, WIN_H/APP_H);
var w = APP_W * ratio;
var h = APP_H * ratio;
var woffset = (WIN_W - w)/2;
var hoffset = (WIN_H - h)/2;
gpu_set_scissor(woffset, hoffset, w, h);