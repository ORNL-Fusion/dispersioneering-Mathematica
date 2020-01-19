# Mathematica notebooks for Plasma RF dispersion relation solvers

1. Plasma_Dispersion_Utilities contains several notebooks that provide dispersion tensor 
and dispersion relation routines as well as notebooks for checking and plotting them.

2.  There are several directories containing notebooks in which the utilities above are used
to look at wave dispersion of some specific machines and specific cases.

Nota Bene: These are notebooks.  You work in them and they change.  There is no permanent 
record unless you seve them separately.  For that reason I'm going to make myself the only 
one to commit (When I figure out how).  I you are interested in using these I suggest you
start your own branch.

Typical usage would be to:

1. Open and evaluate Plasma_Dispersion_Utilities/Plasma_Dispersion.nb.  This gets you the
dispersion tensor and dispersion relation routines.

2) Open and evaluate Plasma_Dispersion_Utilities/PlotPack.nb.  This gets you some plotting
and printing routines tailored for dispersioneering.

3) Open (or generate) and evaluate a notebook containing machine/rf/plot parameters for a 
case you want to work with.

4) Open or generate a notebook that does the particular solutions or plots you want to do.
These are essentially sandboxes to play in.  An example is in DIII-D_ECH_Linear_Slab_Parameters.pdf
and Warm_DIII-D_with_Slab_Profiles.pdf files.

There are warm and cold plasma dispersion tensor and dispersion function routines.  The
most elaborate of these is EpsGeneral. It allows different plasma models for the conductivity 
of each species. 
Returns a 6 element list in the order Eps{xx,yy,zz,xy,xz,yz}

Uses routines: SigmaCold, SigmaCoeff, SigmaMaxn

List model_List specifies which plasma model is used for a given species:
	0 <-> cold plasma
	1 <-> Warm plasma expanded to 2nd order
	2 <-> Hot Plasma with full Bessel functions

Lists nmin_List and nmax_List specify how many harmonics are used in full Bessel model (model 2)

All of these routines contain data for 6 plasma species {e, H, D, T, 3He, 4He}.  The species
makeup of the plasma is set in a length 5 input list etaList, which gives species concentration as
a fraction of electron density.
 