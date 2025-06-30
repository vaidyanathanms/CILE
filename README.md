Install fftool, clandp and packmol first

For the example, I am considering c4c1im as organic cation and ntf2 as anion.

Step-1: `cd CILE`
where CILE is the main directory where the source codes are installed

Step-2: `cd src_gmx/make_itp_from_fftool`

Step-3: Either edit `gen_itp_pdb.sh` and run for each moiety in the system or follow Steps-3(a)-8 for each moiety.
`gen_itp_pdb.sh` is a shell script that automates Steps-3(a) - 8.

Step-3(a): Convert organic cation zmat (in clandp directory) to xyz and copy to current directory.

`/path/to/fftool/fftool 1 /path/to/clandp/c4c1im.zmat 0 /path/to/clandp/ntf2.zmat --rho 1.0
cp /path/to/clandp/c4c1im.xyz .`

Step-3(b): Use packmol to create `simbox.xyz` and then use `fftool` to create `config.pdb` and `field.top`
```
/path/to/packmol/packmol < pack.inp
/path/to/fftool/fftool 1 ~/tools/clandp/ntf2.zmat -r 1 -g
cp config.pdb c4c1im.pdb
cp field.top c4c1im.top
```

Step-4: Same as step-3(a) and 3(b) for anion

/path/to/fftool/fftool 1 /path/to/clandp/ntf2.zmat --rho 1.0
cp /path/to/clandp/ntf2.xyz .
/path/to/packmol/packmol < pack.inp
/path/to/fftool/fftool 1 ~/tools/clandp/ntf2.zmat -r 1 -g
cp config.pdb ntf2.pdb
cp field.top ntf2.top

Step-5 Copy pdb to allcoord_files directory for backup
cp ntf2.pdb ../allcoord_files/
cp c4c1im.pdb ../allcoord_files/

Step-6: Use CHARMM-GUI to create the diluent and Lithium pdb/top
 
Step-7: Go to packmol folder and edit the packmol script
cd ../../src_pack
Edit the paths to input xyz files and output files

Step-8: Edit make_mixture.inp with the right values for box size and anion/cation/organic cation details. 
