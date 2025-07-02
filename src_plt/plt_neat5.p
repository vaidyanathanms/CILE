#1. Plot Li-FSI
set terminal png
set termopt enhanced
set output 'results_5/Li_FSI.png'
set title 'Li-FSI'
set xlabel 'r (nm)' font ",15"
set ylabel 'n(r)/g(r)-(Li-FSI)' font ",15"
unset key
p [0.15:0.5] "LiFSI100_C2C1Im5p0_TTE0p0/nrdf_Li_fsi2.xvg" u 1:2 w l \
 lw 3 lc rgb 'black' title 'n(r) IL:Li = 2, TTE:Li = 0.0',\
 "LiFSI100_C2C1Im5p0_TTE0p5/nrdf_Li_fsi2.xvg" u 1:2 w l \
 lw 3 lc rgb 'red' title 'n(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/nrdf_Li_fsi2.xvg" u 1:2 w l \
 lw 3 lc rgb 'green' title 'n(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE0p0/nrdf_Li_fsi2.xvg" u 1:2 w l\
 lw 3 lc rgb 'blue' title 'n(r) IL:Li = 2, TTE:Li = 0.0', \
 "LiFSI100_C2C1Im5p0_TTE0p0/rdfresults_1.0/rdf_Li_fsi2.xvg" u 1:2\
 lc rgb 'black' title 'g(r) IL:Li = 2, TTE:Li = 0.0', \
 "LiFSI100_C2C1Im5p0_TTE0p5/rdfresults_1.0/rdf_Li_fsi2.xvg" u 1:2\
 lc rgb 'red' title 'g(r) IL:Li = 2, TTE:Li = 0.2', \
 "LiFSI100_C2C1Im5p0_TTE1p5/rdfresults_1.0/rdf_Li_fsi2.xvg" u 1:2\
 lc rgb 'green' title 'g(r) IL:Li = 2, TTE:Li = 0.6', \
 "LiFSI100_C2C1Im5p0_TTE5p0/rdfresults_1.0/rdf_Li_fsi2.xvg" u 1:2\
 lc rgb 'blue' title 'g(r) IL:Li = 2, TTE:Li = 2.0'
unset key

#2. Plot Li-O (FSI)
set terminal png
set termopt enhanced
set output 'results_5/Li_OFSI.png'
set title 'Li-O_{FSI}'
set xlabel 'r (nm)' font ",15"
set ylabel 'n(r)/g(r)-(Li-O,FSI)' font ",15"
p [0.15:0.35] "LiFSI100_C2C1Im5p0_TTE0p0/nrdf_li_Ofsi.xvg" u 1:2 w l \
 lw 3 lc rgb 'black' title 'n(r) IL:Li = 2, TTE:Li = 0.0',\
 "LiFSI100_C2C1Im5p0_TTE0p5/nrdf_li_Ofsi.xvg" u 1:2 w l \
 lw 3 lc rgb 'red' title 'n(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/nrdf_li_Ofsi.xvg" u 1:2 w l \
 lw 3 lc rgb 'green' title 'n(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/nrdf_li_Ofsi.xvg" u 1:2 w l\
 lw 3 lc rgb 'blue' title 'n(r) IL:Li = 2, TTE:Li = 2.0', \
 "LiFSI100_C2C1Im5p0_TTE0p0/rdfresults_1.0/rdf_li_Ofsi.xvg" u 1:2\
 lc rgb 'black' title 'g(r) IL:Li = 2, TTE:Li = 0.0',\
 "LiFSI100_C2C1Im5p0_TTE0p5/rdfresults_1.0/rdf_li_Ofsi.xvg" u 1:2\
 lc rgb 'red' title 'g(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/rdfresults_1.0/rdf_li_Ofsi.xvg" u 1:2\
 lc rgb 'green' title 'g(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/rdfresults_1.0/rdf_li_Ofsi.xvg" u 1:2\
 lw 3 lc rgb 'blue' title 'g(r) IL:Li = 2, TTE:Li = 2.0'
unset key

#3. Plot Li-N,FSI
set terminal png
set termopt enhanced
set output 'results_5/Li_NFSI.png'
set title 'Li-N, FSI'
set xlabel 'r (nm)' font ",15"
set ylabel 'n(r)/g(r)-(Li-N,FSI)' font ",15"
p [0.15:0.35] "LiFSI100_C2C1Im5p0_TTE0p0/nrdf_li_Nfsi.xvg" u 1:2 w l \
 lw 3 lc rgb 'black' title 'n(r) IL:Li = 2, TTE:Li = 0.0',\
 "LiFSI100_C2C1Im5p0_TTE0p5/nrdf_li_Nfsi.xvg" u 1:2 w l \
 lw 3 lc rgb 'red' title 'n(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/nrdf_li_Nfsi.xvg" u 1:2 w l \
 lw 3 lc rgb 'green' title 'n(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/nrdf_li_Nfsi.xvg" u 1:2 w l\
 lw 3 lc rgb 'blue' title 'n(r) IL:Li = 2, TTE:Li = 2.0', \
 "LiFSI100_C2C1Im5p0_TTE0p0/rdfresults_1.0/rdf_li_Nfsi.xvg" u 1:2\
 lc rgb 'black' title 'g(r) IL:Li = 2, TTE:Li = 0.0',\
 "LiFSI100_C2C1Im5p0_TTE0p5/rdfresults_1.0/rdf_li_Nfsi.xvg" u 1:2\
 lc rgb 'red' title 'g(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/rdfresults_1.0/rdf_li_Nfsi.xvg" u 1:2\
 lc rgb 'green' title 'g(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/rdfresults_1.0/rdf_li_Nfsi.xvg" u 1:2\
 lw 3 lc rgb 'blue' title 'g(r) IL:Li = 2, TTE:Li = 2.0'
unset key

#4. Plot FSI-IL
set terminal png
set termopt enhanced
set output 'results_5/c2c_FSI.png'
set title 'IL-FSI'
set xlabel 'r (nm)' font ",15"
set ylabel 'n(r)/g(r)-(IL-FSI)' font ",15"
p [0.15:0.8][0:10] "LiFSI100_C2C1Im5p0_TTE0p0/nrdf_c2c_fsi2.xvg" u 1:2 w l \
 lw 3 lc rgb 'black' title 'n(r) IL:Li = 2, TTE:Li = 0.0',\
 "LiFSI100_C2C1Im5p0_TTE0p5/nrdf_c2c_fsi2.xvg" u 1:2 w l \
 lw 3 lc rgb 'red' title 'n(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/nrdf_c2c_fsi2.xvg" u 1:2 w l \
 lw 3 lc rgb 'green' title 'n(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/nrdf_c2c_fsi2.xvg" u 1:2 w l\
 lw 3 lc rgb 'blue' title 'n(r) IL:Li = 2, TTE:Li = 2.0', \
 "LiFSI100_C2C1Im5p0_TTE0p0/rdfresults_1.0/rdf_c2c_fsi2.xvg" u 1:2\
 lc rgb 'black' title 'g(r) IL:Li = 2, TTE:Li = 0.0',\
 "LiFSI100_C2C1Im5p0_TTE0p5/rdfresults_1.0/rdf_c2c_fsi2.xvg" u 1:2\
 lc rgb 'red' title 'g(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/rdfresults_1.0/rdf_c2c_fsi2.xvg" u 1:2\
 lc rgb 'green' title 'g(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/rdfresults_1.0/rdf_c2c_fsi2.xvg" u 1:2\
 lw 3 lc rgb 'blue' title 'g(r) IL:Li = 2, TTE:Li = 2.0'
unset key

#5. Plot IL-FSI-COM
set terminal png
set termopt enhanced
set output 'results_5/c2c_FSIcom.png'
set title 'IL-FSI,COM'
set xlabel 'r (nm)' font ",15"
set ylabel 'n(r)/g(r)-(IL-FSI,COM)' font ",15"
p [0.15:0.8][0:10] "LiFSI100_C2C1Im5p0_TTE0p0/nrdf_c2c_fsi2com.xvg" u 1:2 w l \
 lw 3 lc rgb 'black' title 'n(r) IL:Li = 2, TTE:Li = 0.0',\
 "LiFSI100_C2C1Im5p0_TTE0p5/nrdf_c2c_fsi2com.xvg" u 1:2 w l \
 lw 3 lc rgb 'red' title 'n(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/nrdf_c2c_fsi2com.xvg" u 1:2 w l \
 lw 3 lc rgb 'green' title 'n(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/nrdf_c2c_fsi2com.xvg" u 1:2 w l\
 lw 3 lc rgb 'blue' title 'n(r) IL:Li = 2, TTE:Li = 2.0', \
 "LiFSI100_C2C1Im5p0_TTE0p0/rdfresults_1.0/rdf_c2c_fsi2com.xvg" u 1:2\
 lc rgb 'black' title 'g(r) IL:Li = 2, TTE:Li = 0.0',\
 "LiFSI100_C2C1Im5p0_TTE0p5/rdfresults_1.0/rdf_c2c_fsi2com.xvg" u 1:2\
 lc rgb 'red' title 'g(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/rdfresults_1.0/rdf_c2c_fsi2com.xvg" u 1:2\
 lc rgb 'green' title 'g(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/rdfresults_1.0/rdf_c2c_fsi2com.xvg" u 1:2\
 lw 3 lc rgb 'blue' title 'g(r) IL:Li = 2, TTE:Li = 2.0'
unset key

#6. Plot IL-TTE-n(r)
set terminal png
set termopt enhanced
set output 'results_5/c2c_TTE_n(r).png'
set title 'n(r): IL-TTE'
set xlabel 'r (nm)' font ",15"
set ylabel 'n(r)-(IL-TTE)' font ",15"
#set key left top
p [0.15:1.5] "LiFSI100_C2C1Im5p0_TTE0p5/nrdf_c2c_TTE2.xvg" u 1:2 w l \
 lw 3 lc rgb 'red' title 'n(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/nrdf_c2c_TTE2.xvg" u 1:2 w l \
 lw 3 lc rgb 'green' title 'n(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/nrdf_c2c_TTE2.xvg" u 1:2 w l\
 lw 3 lc rgb 'blue' title 'n(r) IL:Li = 2, TTE:Li = 2.0'
unset key

#7. Plot IL-TTE-g(r)
set terminal png
set termopt enhanced
set output 'results_5/c2c_TTE_gofr.png'
set title 'g(r): IL-TTE'
set xlabel 'r (nm)' font ",15"
set ylabel 'g(r)-(IL-TTE)' font ",15"
#set key left top
p [0.15:1.5] "LiFSI100_C2C1Im5p0_TTE0p5/rdfresults_1.0/rdf_c2c_TTE2.xvg" u 1:2\
 lc rgb 'red' title 'g(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/rdfresults_1.0/rdf_c2c_TTE2.xvg" u 1:2\
 lc rgb 'green' title 'g(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/rdfresults_1.0/rdf_c2c_TTE2.xvg" u 1:2\
 lw 3 lc rgb 'blue' title 'g(r) IL:Li = 2, TTE:Li = 2.0'
unset key

#8. Plot FSI-TTE-n(r)
set terminal png
set termopt enhanced
set output 'results_5/TTE-fsi_nofr.png'
set title 'n(r): TTE-fsi'
set xlabel 'r (nm)' font ",15"
set ylabel 'n(r)-(TTE-FSI)' font ",15"
#set key left top
p [0.15:1] "LiFSI100_C2C1Im5p0_TTE0p5/nrdf_TTE_fsi2.xvg" u 1:2 w l \
 lw 3 lc rgb 'red' title 'n(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/nrdf_TTE_fsi2.xvg" u 1:2 w l \
 lw 3 lc rgb 'green' title 'n(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/nrdf_TTE_fsi2.xvg" u 1:2 w l\
 lw 3 lc rgb 'blue' title 'n(r) IL:Li = 2, TTE:Li = 2.0'
unset key

#9. Plot FSI-TTE-g(r)
set terminal png
set termopt enhanced
set output 'results_5/TTE-fsi_gofr.png'
set title 'g(r): TTE-fsi'
set xlabel 'r (nm)' font ",15"
set ylabel 'g(r)-(TTE-FSI)' font ",15"
#set key left top
p [0.15:2] "LiFSI100_C2C1Im5p0_TTE0p5/rdfresults_1.0/rdf_TTE_fsi2.xvg" u 1:2\
 lc rgb 'red' title 'g(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/rdfresults_1.0/rdf_TTE_fsi2.xvg" u 1:2\
 lc rgb 'green' title 'g(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/rdfresults_1.0/rdf_TTE_fsi2.xvg" u 1:2\
 lw 3 lc rgb 'blue' title 'g(r) IL:Li = 2, TTE:Li = 2.0'
unset key

#10. Plot Li-TTE-n(r)
set terminal png
set termopt enhanced
set output 'results_5/Li_TTE_nofr.png'
set title 'n(r): Li-TTE'
set xlabel 'r (nm)' font ",15"
set ylabel 'n(r) (Li-TTE)' font ",15"
#set key left top
p [0.15:2.0] "LiFSI100_C2C1Im5p0_TTE0p5/nrdf_Li_TTE2.xvg" u 1:2 w l \
 lw 3 lc rgb 'red' title 'n(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/nrdf_Li_TTE2.xvg" u 1:2 w l \
 lw 3 lc rgb 'green' title 'n(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/nrdf_Li_TTE2.xvg" u 1:2 w l\
 lw 3 lc rgb 'blue' title 'n(r) IL:Li = 2, TTE:Li = 2.0'
unset key

#11. Plot Li-TTE-g(r)
set terminal png
set termopt enhanced
set output 'results_5/Li_TTE_gofr.png'
set title 'g(r): Li-TTE'
set xlabel 'r (nm)' font ",15"
set ylabel 'g(r) (Li-TTE)' font ",15"
#set key left top
p [0.15:2.0] "LiFSI100_C2C1Im5p0_TTE0p5/rdfresults_1.0/rdf_Li_TTE2.xvg" u 1:2\
 lc rgb 'red' title 'g(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/rdfresults_1.0/rdf_Li_TTE2.xvg" u 1:2\
 lc rgb 'green' title 'g(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/rdfresults_1.0/rdf_Li_TTE2.xvg" u 1:2\
 lw 3 lc rgb 'blue' title 'g(r) IL:Li = 2, TTE:Li = 2.0'
unset key

#12. Plot IL-FSI-n(r)
set terminal png
set termopt enhanced
set output 'results_5/c2c_FSI_nofr.png'
set title 'n(r): IL-FSI'
set xlabel 'r (nm)' font ",15"
set ylabel 'n(r)-(IL-FSI)' font ",15"
#set key left top
p [0.15:0.4] "LiFSI100_C2C1Im5p0_TTE0p0/nrdf_c2c_fsi2.xvg" u 1:2 w l \
 lw 3 lc rgb 'black' title 'n(r) IL:Li = 2, TTE:Li = 0.0',\
 "LiFSI100_C2C1Im5p0_TTE0p5/nrdf_c2c_fsi2.xvg" u 1:2 w l \
 lw 3 lc rgb 'red' title 'n(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/nrdf_c2c_fsi2.xvg" u 1:2 w l \
 lw 3 lc rgb 'green' title 'n(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/nrdf_c2c_fsi2.xvg" u 1:2 w l\
 lw 3 lc rgb 'blue' title 'n(r) IL:Li = 2, TTE:Li = 2.0'
unset key

#13. Plot IL-FSI-g(r)
set terminal png
set termopt enhanced
set output 'results_5/c2c_FSI_gofr.png'
set title 'g(r): IL-FSI'
set xlabel 'r (nm)' font ",15"
set ylabel 'g(r) (IL-FSI)' font ",15"
#set key left top
p [0.15:0.7] "LiFSI100_C2C1Im5p0_TTE0p0/rdfresults_1.0/rdf_c2c_fsi2.xvg" u 1:2\
 lc rgb 'black' title 'g(r) IL:Li = 2, TTE:Li = 0.0',\
 "LiFSI100_C2C1Im5p0_TTE0p5/rdfresults_1.0/rdf_c2c_fsi2.xvg" u 1:2\
 lc rgb 'red' title 'g(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/rdfresults_1.0/rdf_c2c_fsi2.xvg" u 1:2\
 lc rgb 'green' title 'g(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/rdfresults_1.0/rdf_c2c_fsi2.xvg" u 1:2\
 lw 3 lc rgb 'blue' title 'g(r) IL:Li = 2, TTE:Li = 2.0'
unset key

#14. Plot IL-TTE-n(r)-zoomed
set terminal png
set termopt enhanced
set output 'results_5/c2c_TTE_n(r)_zoomed.png'
set title 'n(r): IL-TTE'
set xlabel 'r (nm)' font ",15"
set ylabel 'n(r)-(IL-TTE)' font ",15"
#set key left top
p [0.15:0.7] "LiFSI100_C2C1Im5p0_TTE0p5/rdfresults_1.0/rdf_li_ftte.xvg" u 1:2 \
 lc rgb 'red' title 'n(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/nrdf_c2c_TTE2.xvg" u 1:2 w l \
 lw 3 lc rgb 'green' title 'n(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/nrdf_c2c_TTE2.xvg" u 1:2 w l\
 lw 3 lc rgb 'blue' title 'n(r) IL:Li = 2, TTE:Li = 2.0'
unset key

#15. Plot IL-FSI-n(r)-Full
set terminal png
set termopt enhanced
set output 'results_5/c2c_FSI_nofr_full.png'
set title 'n(r): IL-FSI'
set xlabel 'r (nm)' font ",15"
set ylabel 'n(r)-(IL-FSI)' font ",15"
#set key left top
p "LiFSI100_C2C1Im5p0_TTE0p0/nrdf_c2c_fsi2.xvg" u 1:2 w l \
 lw 3 lc rgb 'black' title 'n(r) IL:Li = 2, TTE:Li = 0.0',\
 "LiFSI100_C2C1Im5p0_TTE0p5/nrdf_c2c_fsi2.xvg" u 1:2 w l \
 lw 3 lc rgb 'red' title 'n(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/nrdf_c2c_fsi2.xvg" u 1:2 w l \
 lw 3 lc rgb 'green' title 'n(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/nrdf_c2c_fsi2.xvg" u 1:2 w l\
 lw 3 lc rgb 'blue' title 'n(r) IL:Li = 2, TTE:Li = 2.0'
unset key

#16. Plot Li-F(TTE)-g(r)
set terminal png
set termopt enhanced
set output 'results_5/Li_FTTE_gofr.png'
set title 'g(r): Li-FTTE'
set xlabel 'r (nm)' font ",15"
set ylabel 'g(r)-(Li-FTTE)' font ",15"
#set key left top
p [0.15:2.0] "LiFSI100_C2C1Im5p0_TTE0p5/rdfresults_1.0/rdf_li_ftte.xvg" u 1:2\
 lc rgb 'red' title 'g(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/rdfresults_1.0/rdf_li_ftte.xvg" u 1:2\
 lc rgb 'green' title 'g(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/rdfresults_1.0/rdf_li_ftte.xvg" u 1:2\
 lw 3 lc rgb 'blue' title 'g(r) IL:Li = 2, TTE:Li = 2.0'
unset key


#16. Plot Li-O(TTE)-g(r)
set terminal png
set termopt enhanced
set output 'results_5/Li_OTTE_gofr.png'
set title 'g(r): Li-OTTE'
set xlabel 'r (nm)' font ",15"
set ylabel 'g(r)-(Li-OTTE)' font ",15"
#set key left top
p [0.15:2.0] "LiFSI100_C2C1Im5p0_TTE0p5/rdfresults_1.0/rdf_li_otte.xvg" u 1:2\
 lc rgb 'red' title 'g(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/rdfresults_1.0/rdf_li_otte.xvg" u 1:2\
 lc rgb 'green' title 'g(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/rdfresults_1.0/rdf_li_otte.xvg" u 1:2\
 lw 3 lc rgb 'blue' title 'g(r) IL:Li = 2, TTE:Li = 2.0'
unset key


#17. Plot Li-F(TTE)-n(r)
set terminal png
set termopt enhanced
set output 'results_5/Li_FTTE_nofr.png'
set title 'n(r): Li-F(TTE)'
set xlabel 'r (nm)' font ",15"
set ylabel 'n(r)-(Li-F(TTE))' font ",15"
#set key left top
p [0.15:0.6] "LiFSI100_C2C1Im5p0_TTE0p5/nrdf_li_ftte.xvg" u 1:2 w l \
 lw 3 lc rgb 'red' title 'n(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/nrdf_li_ftte.xvg" u 1:2 w l \
 lw 3 lc rgb 'green' title 'n(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/nrdf_li_ftte.xvg" u 1:2 w l\
 lw 3 lc rgb 'blue' title 'n(r) IL:Li = 2, TTE:Li = 2.0'
unset key

#18. Plot Li-O(TTE)-n(r)
set terminal png
set termopt enhanced
set output 'results_5/Li_OTTE_nofr.png'
set title 'n(r): Li-O(TTE)'
set xlabel 'r (nm)' font ",15"
set ylabel 'n(r)-(Li-O(TTE))' font ",15"
#set key left top
p [0.15:0.6] "LiFSI100_C2C1Im5p0_TTE0p5/nrdf_li_otte.xvg" u 1:2 w l \
 lw 3 lc rgb 'red' title 'n(r) IL:Li = 2, TTE:Li = 0.2',\
 "LiFSI100_C2C1Im5p0_TTE1p5/nrdf_li_otte.xvg" u 1:2 w l \
 lw 3 lc rgb 'green' title 'n(r) IL:Li = 2, TTE:Li = 0.6',\
 "LiFSI100_C2C1Im5p0_TTE5p0/nrdf_li_otte.xvg" u 1:2 w l\
 lw 3 lc rgb 'blue' title 'n(r) IL:Li = 2, TTE:Li = 2.0'
unset key

