// Languages: name (local), name_en, name_fr, name_es, name_de
@name: '[name_en]';

// Fonts //
@fallback: 'Open Sans Regular';
@sans: 'Open Sans Regular', 'Arial Unicode MS Regular';
@sans_md: 'Open Sans Semibold', 'Arial Unicode MS Regular';
@sans_bd: 'Open Sans Bold','Arial Unicode MS Bold';
@sans_it: 'Open Sans Italic', 'Arial Unicode MS Regular';
@sans_bdit: 'Open Sans Bold Italic','Arial Unicode MS Bold';

/*
This style is designed to be easily recolored by adjusting the color
variables below. For predicatable feature relationships,
maintain or invert existing value (light to dark) scale.
*/

// Color palette //
@road:  #484848;
@land:  #0e0d0d;
@github-users: #95f6f2;

@fill1: #000000;
@fill2: #444444;
@fill3: #888888;
@fill4: #ffffff;
@fill5: #7a7a7a;

@text: #888888;

Map { background-color: @land; }

// Political boundaries //
#admin[admin_level=2][maritime=0] {
  line-join: round;
  line-color: @fill5;
  line-width: 1;
  [zoom>=5] { line-width: 1.4; }
  [zoom>=6] { line-width: 1.8; }
  [zoom>=8] { line-width: 2; }
  [zoom>=10] { line-width: 3; }
  [disputed=1] { line-dasharray: 4,4; }
}


// Land Features //
#landuse[class='cemetery'],
#landuse[class='park'],
#landuse[class='wood'],
#landuse_overlay {
  polygon-fill: darken(@land,3);
  [zoom>=15] { polygon-fill:mix(@land,@fill4,95); }
}

#landuse[class='pitch'],
#landuse[class='sand'] { 
  polygon-fill: mix(@land,@fill4,90);
}

#building { 
  polygon-fill: mix(@fill2,@land,25);
  [zoom>=16]{ polygon-fill: mix(@fill2,@land,50);}
}

// Water Features //
#water {
  ::shadow {
    polygon-fill: mix(@water,@fill4,75);
    
  }
  ::fill {
    // a fill and overlay comp-op lighten the polygon-
    // fill from ::shadow.
    polygon-fill: @land;
    comp-op: soft-light;
    // blurring reveals the polygon fill from ::shadow around
    // the edges of the water
    image-filters: agg-stack-blur(10,10);
    image-filters-inflate: true;
  }
}

// Water color is calculated by sampling the resulting color from
// the soft-light comp-op in the #water layer style above. 
@water: #363939;

#waterway {
  [type='river'],
  [type='canal'] {
    line-color: @water;
    line-width: 0.5;
    [zoom>=12] { line-width: 1; }
    [zoom>=14] { line-width: 2; }
    [zoom>=16] { line-width: 3; }
  }
  [type='stream'] {
    line-color: @water;
    line-width: 0.5;
    [zoom>=14] { line-width: 1; }
    [zoom>=16] { line-width: 2; }
    [zoom>=18] { line-width: 3; }
  }
}