constant MAX_ITERATIONS = 50;
my $width = my $height = +(@*ARGS[0] // 30);

sub cut(Range $r, Int $n where $n > 1) {
    $r.min, * + ($r.max - $r.min) / ($n - 1) ... $r.max
}

my @re = cut(-2 .. 1/2, $height);
my $im = [ cut( 0 .. 5/4, $width div 2 + 1) X* 1i ];

constant @color_map = map ~*.comb(/../).map({:16($_)}), <
000000 0000fc 4000fc 7c00fc bc00fc fc00fc fc00bc fc007c fc0040 fc0000 fc4000
fc7c00 fcbc00 fcfc00 bcfc00 7cfc00 40fc00 00fc00 00fc40 00fc7c 00fcbc 00fcfc
00bcfc 007cfc 0040fc 7c7cfc 9c7cfc bc7cfc dc7cfc fc7cfc fc7cdc fc7cbc fc7c9c
fc7c7c fc9c7c fcbc7c fcdc7c fcfc7c dcfc7c bcfc7c 9cfc7c 7cfc7c 7cfc9c 7cfcbc
7cfcdc 7cfcfc 7cdcfc 7cbcfc 7c9cfc b4b4fc c4b4fc d8b4fc e8b4fc fcb4fc fcb4e8
fcb4d8 fcb4c4 fcb4b4 fcc4b4 fcd8b4 fce8b4 fcfcb4 e8fcb4 d8fcb4 c4fcb4 b4fcb4
b4fcc4 b4fcd8 b4fce8 b4fcfc b4e8fc b4d8fc b4c4fc 000070 1c0070 380070 540070
700070 700054 700038 70001c 700000 701c00 703800 705400 707000 547000 387000
1c7000 007000 00701c 007038 007054 007070 005470 003870 001c70 383870 443870
543870 603870 703870 703860 703854 703844 703838 704438 705438 706038 707038
607038 547038 447038 387038 387044 387054 387060 387070 386070 385470 384470
505070 585070 605070 685070 705070 705068 705060 705058 705050 705850 706050
706850 707050 687050 607050 587050 507050 507058 507060 507068 507070 506870
506070 505870 000040 100040 200040 300040 400040 400030 400020 400010 400000
401000 402000 403000 404000 304000 204000 104000 004000 004010 004020 004030
004040 003040 002040 001040 202040 282040 302040 382040 402040 402038 402030
402028 402020 402820 403020 403820 404020 384020 304020 284020 204020 204028
204030 204038 204040 203840 203040 202840 2c2c40 302c40 342c40 3c2c40 402c40
402c3c 402c34 402c30 402c2c 40302c 40342c 403c2c 40402c 3c402c 34402c 30402c
2c402c 2c4030 2c4034 2c403c 2c4040 2c3c40 2c3440 2c3040
>;

sub mandelbrot( Complex $c ) {
    my $im2 = $c.im**2;
    return 0 if ($c.re + 1)**2 + $im2 < 1/16;
    my $q = ($c.re - 1/4)**2 + $im2;
    return 0 if $q*($q + ($c.re - 1/4)) < $im2/4;
    my $z = 0i;
    for ^MAX_ITERATIONS -> $i {
        return $i + 1 if $z.re**2 + $z.im**2 > 4;
        $z = $z * $z + $c;
    }
    return 0;
}

my @promises = map -> $re {
    start { [ mandelbrot($re + $_) for @$im ] }
}, @re;

say "P3";
say "$width $height";
say "255";

for @promises».result {
    say @color_map[(flat .reverse, .[1..*])[^$width]];
}
