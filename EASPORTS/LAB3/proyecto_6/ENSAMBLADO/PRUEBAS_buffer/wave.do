onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /prueba_ensamblado_multi/ciclo
add wave -noupdate /prueba_ensamblado_multi/reloj
add wave -noupdate /prueba_ensamblado_multi/pcero
add wave -noupdate -radix unsigned -childformat {{/prueba_ensamblado_multi/peticiones(0) -radix unsigned -childformat {{/prueba_ensamblado_multi/peticiones(0).acc -radix unsigned} {/prueba_ensamblado_multi/peticiones(0).dir -radix unsigned} {/prueba_ensamblado_multi/peticiones(0).esc -radix unsigned} {/prueba_ensamblado_multi/peticiones(0).ini -radix unsigned} {/prueba_ensamblado_multi/peticiones(0).DE -radix unsigned}}} {/prueba_ensamblado_multi/peticiones(1) -radix unsigned}} -subitemconfig {/prueba_ensamblado_multi/peticiones(0) {-height 16 -radix unsigned -childformat {{/prueba_ensamblado_multi/peticiones(0).acc -radix unsigned} {/prueba_ensamblado_multi/peticiones(0).dir -radix unsigned} {/prueba_ensamblado_multi/peticiones(0).esc -radix unsigned} {/prueba_ensamblado_multi/peticiones(0).ini -radix unsigned} {/prueba_ensamblado_multi/peticiones(0).DE -radix unsigned}}} /prueba_ensamblado_multi/peticiones(0).acc {-height 16 -radix unsigned} /prueba_ensamblado_multi/peticiones(0).dir {-height 16 -radix unsigned} /prueba_ensamblado_multi/peticiones(0).esc {-height 16 -radix unsigned} /prueba_ensamblado_multi/peticiones(0).ini {-height 16 -radix unsigned} /prueba_ensamblado_multi/peticiones(0).DE {-height 16 -radix unsigned} /prueba_ensamblado_multi/peticiones(1) {-height 16 -radix unsigned}} /prueba_ensamblado_multi/peticiones
add wave -noupdate -divider ARBITRAJE
add wave -noupdate /prueba_ensamblado_multi/ensa_ca_mem/arbitraje/arb_peticiones
add wave -noupdate -expand /prueba_ensamblado_multi/ensa_ca_mem/arbitraje/arb_concesiones
add wave -noupdate /prueba_ensamblado_multi/ensa_ca_mem/arbitraje/fin_trans
add wave -noupdate -divider {CACHE 0}
add wave -noupdate -divider Campos
add wave -noupdate -height 16 -radix unsigned /prueba_ensamblado_multi/ensa_ca_mem/proc_multi(0)/cache/cach/cache_sin/camino/etiq/ET_Mem/ET_mem(0)
add wave -noupdate -height 16 -radix unsigned /prueba_ensamblado_multi/ensa_ca_mem/proc_multi(0)/cache/cach/cache_sin/camino/etiq/ET_Mem/ET_mem(1)
add wave -noupdate /prueba_ensamblado_multi/ensa_ca_mem/proc_multi(0)/cache/cach/cache_sin/camino/estado/EST_mem(0)
add wave -noupdate /prueba_ensamblado_multi/ensa_ca_mem/proc_multi(0)/cache/cach/cache_sin/camino/estado/EST_mem(1)
add wave -noupdate -height 16 -radix unsigned /prueba_ensamblado_multi/ensa_ca_mem/proc_multi(0)/cache/cach/cache_sin/camino/datos_ca/DAT_Mem/DAT_mem(0)
add wave -noupdate -height 16 -radix unsigned /prueba_ensamblado_multi/ensa_ca_mem/proc_multi(0)/cache/cach/cache_sin/camino/datos_ca/DAT_Mem/DAT_mem(1)
add wave -noupdate -divider {Estado CC_proc}
add wave -noupdate /prueba_ensamblado_multi/ensa_ca_mem/proc_multi(0)/cache/cach/cache_sin/contro/contro_proc/estado
add wave -noupdate -divider {Estados CC_Obser}
add wave -noupdate /prueba_ensamblado_multi/ensa_ca_mem/proc_multi(0)/cache/cach/cache_sin/contro/contro_obser/estado
add wave -noupdate -divider {CACHE 1}
add wave -noupdate -divider Campos
add wave -noupdate -radix unsigned /prueba_ensamblado_multi/ensa_ca_mem/proc_multi(1)/cache/cach/cache_sin/camino/etiq/ET_Mem/ET_mem(0)
add wave -noupdate -radix unsigned /prueba_ensamblado_multi/ensa_ca_mem/proc_multi(1)/cache/cach/cache_sin/camino/etiq/ET_Mem/ET_mem(1)
add wave -noupdate /prueba_ensamblado_multi/ensa_ca_mem/proc_multi(1)/cache/cach/cache_sin/camino/estado/EST_mem(0)
add wave -noupdate /prueba_ensamblado_multi/ensa_ca_mem/proc_multi(1)/cache/cach/cache_sin/camino/estado/EST_mem(1)
add wave -noupdate -height 16 -radix unsigned /prueba_ensamblado_multi/ensa_ca_mem/proc_multi(1)/cache/cach/cache_sin/camino/datos_ca/DAT_Mem/DAT_mem(0)
add wave -noupdate -height 16 -radix unsigned /prueba_ensamblado_multi/ensa_ca_mem/proc_multi(1)/cache/cach/cache_sin/camino/datos_ca/DAT_Mem/DAT_mem(1)
add wave -noupdate -divider {Estado CC_proc}
add wave -noupdate /prueba_ensamblado_multi/ensa_ca_mem/proc_multi(1)/cache/cach/cache_sin/contro/contro_proc/estado
add wave -noupdate -divider {Estado CC_obser}
add wave -noupdate /prueba_ensamblado_multi/ensa_ca_mem/proc_multi(1)/cache/cach/cache_sin/contro/contro_obser/estado
add wave -noupdate -divider MEMORIA
add wave -noupdate -radix unsigned /prueba_ensamblado_multi/ensa_ca_mem/memoria/memoria/mem/mem(0)
add wave -noupdate -radix unsigned /prueba_ensamblado_multi/ensa_ca_mem/memoria/memoria/mem/mem(17)
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9229 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 151
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 40000
configure wave -gridperiod 80000
configure wave -griddelta 20
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {13188 ns}
