# Begin generated code

# end libs
.namespace [ ]

.sub 'main' :main
.param pmc __ARG_1

.annotate 'file', '../deepclone/setup.winxed'
.annotate 'line', 23
# Body
# {
.annotate 'line', 24
load_bytecode 'distutils.pbc'
.annotate 'line', 27
__ARG_1.'shift'()
.annotate 'line', 29
get_hll_global $P2, 'build_pir_winxed'
.annotate 'line', 30
get_hll_global $P3, 'build_c_dynext'
.annotate 'line', 31
'register_step_before'('build', $P2)
.annotate 'line', 32
'register_step_after'('build', $P3)
.annotate 'line', 34
get_hll_global $P4, 'clean_pir_winxed'
.annotate 'line', 35
get_hll_global $P5, 'clean_c_dynext'
.annotate 'line', 36
'register_step_after'('clean', $P4)
.annotate 'line', 37
'register_step_before'('clean', $P5)
.annotate 'line', 39
# var conf: $P1
$P1 = 'load_setup_json'()
.annotate 'line', 40
'setup'(__ARG_1 :flat, $P1 :flat :named)
# }
.annotate 'line', 41

.end # main


.sub 'load_setup_json'

.annotate 'line', 54
# Body
# {
.annotate 'line', 55
# var file: $P1
# predefined open
root_new $P1, ['parrot';'FileHandle']
$P1.'open'('setup.json')
.annotate 'line', 56
# string json_str: $S1
$P4 = $P1.'readall'()
null $S1
if_null $P4, __label_0
set $S1, $P4
__label_0:
.annotate 'line', 57
$P1.'close'()
.annotate 'line', 58
# var json: $P2
# predefined load_language
load_language 'data_json'
compreg $P2, 'data_json'
.annotate 'line', 59
# var promise: $P3
$P3 = $P2.'compile'($S1)
.annotate 'line', 60
.tailcall $P3()
# }
.annotate 'line', 61

.end # load_setup_json


.sub 'build_pir_winxed'
.param pmc __ARG_1 :named :slurpy

.annotate 'line', 74
# Body
# {
.annotate 'line', 75
# var hash: $P1
$P1 = __ARG_1['pir_winxed']
.annotate 'line', 77
isfalse $I1, $P1
unless $I1 goto __label_0
.return()
__label_0: # endif
.annotate 'line', 79
# string flags: $S1
$P5 = 'get_value'('pir_winxed_flags', '' :named('default'), __ARG_1 :flat :named)
null $S1
if_null $P5, __label_1
set $S1, $P5
__label_1:
.annotate 'line', 81
# var jobs: $P2
new $P2, [ 'ResizableStringArray' ]
.annotate 'line', 83
# var temp: $P3
null $P3
.annotate 'line', 84
# pirop loadlib
loadlib $P3, 'os'
.annotate 'line', 86
iter $P6, $P1
set $P6, 0
__label_2: # for iteration
unless $P6 goto __label_3
shift $S2, $P6
# {
.annotate 'line', 87
# string winxed: $S3
$S3 = $P1[$S2]
.annotate 'line', 89
$P5 = 'newer'($S2, $S3)
if_null $P5, __label_4
unless $P5 goto __label_4
goto __label_2 # continue
__label_4: # endif
.annotate 'line', 91
$P7 = 'dirname'($S2)
'mkpath'($P7, 1 :named('verbose'))
.annotate 'line', 93
# var os: $P4
new $P4, [ 'OS' ]
.annotate 'line', 94
# string cwd: $S4
$P7 = $P4.'cwd'()
null $S4
if_null $P7, __label_5
set $S4, $P7
__label_5:
.annotate 'line', 95
# string cmd: $S5
root_new $P8, ['parrot';'ResizablePMCArray']
.annotate 'line', 96
$P10 = 'get_winxed_dir'()
.annotate 'line', 95
$P8.'push'($P10)
concat $S7, $S4, '/'
concat $S6, $S7, $S2
box $P9, $S6
$P8.'push'($P9)
box $P9, $S1
$P8.'push'($P9)
concat $S9, $S4, '/'
concat $S8, $S9, $S3
box $P9, $S8
$P8.'push'($P9)
# predefined sprintf
sprintf $S5, "cd %s; ./winxed --target=pir -o %s %s %s", $P8
.annotate 'line', 99
$P2.'push'($S5)
# }
goto __label_2
__label_3: # endfor
.annotate 'line', 102
'run_jobs'($P2)
# }
.annotate 'line', 103

.end # build_pir_winxed


.sub 'get_winxed_dir'

.annotate 'line', 116
# Body
# {
.annotate 'line', 117
# var env: $P1
new $P1, [ 'Env' ]
.annotate 'line', 118
# string path: $S1
$S1 = $P1['WINXED_PATH']
.annotate 'line', 119
iseq $I1, $S1, ''
unless $I1 goto __label_0
# predefined die
.annotate 'line', 120
die "Cannot find winxed.\nPlease add $WINXED_PATH to your environment\nor bug NotFound about making winxed installable.\n"
__label_0: # endif
.annotate 'line', 123
.return($S1)
# }
.annotate 'line', 124

.end # get_winxed_dir


.sub 'clean_pir_winxed'
.param pmc __ARG_1 :named :slurpy

.annotate 'line', 137
# Body
# {
.annotate 'line', 138
# var hash: $P1
$P1 = __ARG_1['pir_winxed']
.annotate 'line', 140
isfalse $I1, $P1
unless $I1 goto __label_0
.return()
__label_0: # endif
.annotate 'line', 142
iter $P2, $P1
set $P2, 0
__label_1: # for iteration
unless $P2 goto __label_2
shift $S1, $P2
.annotate 'line', 143
'unlink'($S1, 1 :named('verbose'))
goto __label_1
__label_2: # endfor
# }
.annotate 'line', 144

.end # clean_pir_winxed


.sub 'build_c_dynext'
.param pmc __ARG_1 :named :slurpy

.annotate 'line', 155
# Body
# {
.annotate 'line', 156
# var hash: $P1
$P1 = __ARG_1['c_dynext']
.annotate 'line', 158
isfalse $I1, $P1
unless $I1 goto __label_0
.return()
__label_0: # endif
.annotate 'line', 160
# var config: $P2
$P2 = 'get_config'()
.annotate 'line', 161
'mkpath'('dynext', 1 :named('verbose'))
.annotate 'line', 163
iter $P7, $P1
set $P7, 0
__label_1: # for iteration
unless $P7 goto __label_2
shift $S1, $P7
# {
.annotate 'line', 164
# var opts: $P3
$P3 = $P1[$S1]
.annotate 'line', 165
# string dyn_file: $S2
$P8 = 'dyn_filename'($S1)
null $S2
if_null $P8, __label_3
set $S2, $P8
__label_3:
.annotate 'line', 168
# string ccflags: $S3
$S3 = $P3['ccflags']
.annotate 'line', 169
$P8 = 'get_cflags'()
$S8 = $P8
concat $S3, $S3, $S8
.annotate 'line', 172
# string ldflags: $S4
root_new $P9, ['parrot';'ResizablePMCArray']
$P11 = $P3['ldflags']
$P9.'push'($P11)
$P12 = $P2['ld_load_flags']
$P9.'push'($P12)
$P14 = $P2['parrot_is_shared']
if_null $P14, __label_5
unless $P14 goto __label_5
$P13 = $P2['inst_libparrot_ldflags']
goto __label_4
__label_5:
set $P13, ''
__label_4:
$P9.'push'($P13)
# predefined join
join $S4, ' ', $P9
.annotate 'line', 177
# var jobs: $P4
new $P4, [ 'ResizableStringArray' ]
.annotate 'line', 178
# var o_files: $P5
new $P5, [ 'ResizableStringArray' ]
.annotate 'line', 179
$P9 = $P3['src']
iter $P15, $P9
set $P15, 0
__label_6: # for iteration
unless $P15 goto __label_7
shift $S5, $P15
# {
.annotate 'line', 180
# var obj: $P6
$P6 = 'c_to_o_file'($S5)
.annotate 'line', 181
$P5.'push'($P6)
.annotate 'line', 183
$P10 = 'newer'($P6, $S5)
if_null $P10, __label_8
unless $P10 goto __label_8
goto __label_6 # continue
__label_8: # endif
.annotate 'line', 186
# string cmd: $S6
root_new $P11, ['parrot';'ResizablePMCArray']
$P13 = $P2['cc']
$P11.'push'($P13)
box $P12, '-c'
$P11.'push'($P12)
$P14 = $P2['cc_o_out']
$P11.'push'($P14)
$P11.'push'($P6)
box $P12, '-I'
$P11.'push'($P12)
.annotate 'line', 188
$P16 = 'get_incdir'()
.annotate 'line', 186
$P11.'push'($P16)
box $P12, '-I'
$P11.'push'($P12)
.annotate 'line', 188
$P17 = 'get_incdir'()
set $I2, $P17
set $I3, '/pmc'
add $I1, $I2, $I3
box $P12, $I1
.annotate 'line', 186
$P11.'push'($P12)
box $P12, '-I'
$P11.'push'($P12)
.annotate 'line', 188
$P18 = 'cwd'()
.annotate 'line', 186
$P11.'push'($P18)
box $P12, $S3
$P11.'push'($P12)
box $P12, $S5
$P11.'push'($P12)
# predefined join
join $S6, ' ', $P11
.annotate 'line', 192
$P4.'push'($S6)
# }
goto __label_6
__label_7: # endfor
.annotate 'line', 195
'run_jobs'($P4)
.annotate 'line', 197
# string cmd: $S7
root_new $P16, ['parrot';'ResizablePMCArray']
$P18 = $P2['ld']
$P16.'push'($P18)
$P19 = $P2['ld_out']
$P16.'push'($P19)
box $P17, $S2
$P16.'push'($P17)
box $P17, $S4
$P16.'push'($P17)
# predefined join
.annotate 'line', 198
join $S8, ' ', $P5
box $P17, $S8
.annotate 'line', 197
$P16.'push'($P17)
# predefined join
join $S7, ' ', $P16
.annotate 'line', 201
'system'($S7, 1 :named('verbose'))
# }
goto __label_1
__label_2: # endfor
# }
.annotate 'line', 205

.end # build_c_dynext


.sub 'clean_c_dynext'
.param pmc __ARG_1 :named :slurpy

.annotate 'line', 216
# Body
# {
.annotate 'line', 217
# var hash: $P1
$P1 = __ARG_1['c_dynext']
.annotate 'line', 219
isfalse $I1, $P1
unless $I1 goto __label_0
.return()
__label_0: # endif
.annotate 'line', 221
iter $P3, $P1
set $P3, 0
__label_1: # for iteration
unless $P3 goto __label_2
shift $S1, $P3
# {
.annotate 'line', 222
# var opts: $P2
$P2 = $P1[$S1]
.annotate 'line', 224
$P4 = $P2['src']
iter $P5, $P4
set $P5, 0
__label_3: # for iteration
unless $P5 goto __label_4
shift $S2, $P5
.annotate 'line', 225
$P6 = 'c_to_o_file'($S2)
'unlink'($P6, 1 :named('verbose'))
goto __label_3
__label_4: # endfor
.annotate 'line', 227
$P4 = 'dyn_filename'($S1)
'unlink'($P4, 1 :named('verbose'))
# }
goto __label_1
__label_2: # endfor
# }
.annotate 'line', 229

.end # clean_c_dynext


.sub 'c_to_o_file'
.param string __ARG_1

.annotate 'line', 240
# Body
# {
.annotate 'line', 241
# int strlen: $I1
# predefined length
length $I1, __ARG_1
.annotate 'line', 242
# string obj_ext: $S1
$P1 = 'get_config'()
$S1 = $P1['o']
.annotate 'line', 243
# string ofile: $S2
sub $I3, $I1, 2
# predefined substr
substr $S3, __ARG_1, $I3, 2
iseq $I2, $S3, '.c'
unless $I2 goto __label_1
sub $I4, $I1, 2
# predefined substr
.annotate 'line', 244
substr $S4, __ARG_1, 0, $I4
concat $S2, $S4, $S1
goto __label_0
__label_1:
concat $S2, __ARG_1, $S1
__label_0:
.annotate 'line', 246
.return($S2)
# }
.annotate 'line', 247

.end # c_to_o_file


.sub 'dyn_filename'
.param string __ARG_1

.annotate 'line', 258
# Body
# {
.annotate 'line', 259
# string load_ext: $S1
$P1 = 'get_load_ext'()
null $S1
if_null $P1, __label_0
set $S1, $P1
__label_0:
concat $S3, 'dynext/lib', __ARG_1
concat $S2, $S3, $S1
.annotate 'line', 260
.return($S2)
# }
.annotate 'line', 261

.end # dyn_filename


.sub 'compile_dynlib'
.param string __ARG_1
.param pmc __ARG_2
.param string __ARG_3
.param string __ARG_4

.annotate 'line', 276
# Body
# {
.annotate 'line', 277
root_new $P4, ['parrot';'ResizablePMCArray']
box $P5, __ARG_3
$P4.'push'($P5)
$P6 = 'get_cflags'()
$P4.'push'($P6)
# predefined join
join __ARG_3, ' ', $P4
.annotate 'line', 278
root_new $P4, ['parrot';'ResizablePMCArray']
box $P5, __ARG_4
$P4.'push'($P5)
$P6 = 'get_ldflags'()
$P4.'push'($P6)
# predefined join
join __ARG_4, ' ', $P4
.annotate 'line', 280
'mkpath'('dynext', 1 :named('verbose'))
.annotate 'line', 282
# string obj_ext: $S1
$P7 = 'get_obj'()
null $S1
if_null $P7, __label_0
set $S1, $P7
__label_0:
.annotate 'line', 283
# var objects: $P1
new $P1, [ 'ResizableStringArray' ]
.annotate 'line', 284
iter $P8, __ARG_2
set $P8, 0
__label_1: # for iteration
unless $P8 goto __label_2
shift $S2, $P8
# {
.annotate 'line', 285
# int strlen: $I1
# predefined length
length $I1, $S2
.annotate 'line', 286
# var obj: $P2
sub $I3, $I1, 2
# predefined substr
substr $S7, $S2, $I3, 2
iseq $I2, $S7, '.c'
unless $I2 goto __label_4
sub $I4, $I1, 2
# predefined substr
.annotate 'line', 287
substr $S8, $S2, 0, $I4
concat $S6, $S8, $S1
goto __label_3
__label_4:
concat $S6, $S2, $S1
__label_3:
box $P2, $S6
.annotate 'line', 289
'__compile_cc'($P2, $S2, __ARG_3)
.annotate 'line', 290
$P1.'push'($P2)
# }
goto __label_1
__label_2: # endfor
.annotate 'line', 293
# var config: $P3
$P3 = 'get_config'()
.annotate 'line', 294
# string load_ext: $S3
$P7 = 'get_load_ext'()
null $S3
if_null $P7, __label_5
set $S3, $P7
__label_5:
.annotate 'line', 295
# string dynext: $S4
concat $S6, 'dynext/', __ARG_1
concat $S4, $S6, $S3
.annotate 'line', 296
# string cmd: $S5
root_new $P9, ['parrot';'ResizablePMCArray']
$P11 = $P3['ld']
$P9.'push'($P11)
$P12 = $P3['ld_out']
$P9.'push'($P12)
box $P10, $S4
$P9.'push'($P10)
box $P10, __ARG_4
$P9.'push'($P10)
$P13 = $P3['ld_load_flags']
$P9.'push'($P13)
$P15 = $P3['parrot_is_shared']
if_null $P15, __label_7
unless $P15 goto __label_7
$P14 = $P3['inst_libparrot_ldflags']
goto __label_6
__label_7:
set $P14, ''
__label_6:
$P9.'push'($P14)
# predefined join
join $S7, ' ', $P9
# predefined join
.annotate 'line', 299
join $S8, ' ', $P1
concat $S5, $S7, $S8
.annotate 'line', 300
'system'($S5, 1 :named('verbose'))
# }
.annotate 'line', 305

.end # compile_dynlib

# End generated code
