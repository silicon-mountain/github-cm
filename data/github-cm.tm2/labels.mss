
// Country labels //
#country_label_line { 
  line-color: @text;
  line-dasharray: 3,3;
  line-width: 1;
}


// ---------------------------------------------------------------------
// Cities, towns, villages, etc

// City labels with dots for low zoom levels.
// The separate attachment keeps the size of the XML down.
#place_label::citydots[type='city'][zoom>=4][zoom<=7][localrank<=3] {
  // explicitly defining all the `ldir` values wer'e going
  // to use shaves a bit off the final project.xml size
  [ldir='N'],[ldir='S'],[ldir='E'],[ldir='W'],
  [ldir='NE'],[ldir='SE'],[ldir='SW'],[ldir='NW'] {
    shield-file: url("shield/dot.svg");
    shield-transform:scale(0.3,0.3);
    shield-unlock-image: true;
    shield-name: @name;
    shield-size: 12;
    shield-face-name: @sans;
    shield-placement: point;
    shield-fill: @text;
    shield-halo-fill: @fill1;
    shield-halo-radius: 2;
    shield-halo-rasterizer: fast;
    shield-margin:30;
    shield-opacity:0.5;
    [zoom=7] { shield-size: 14; }

    [ldir='E'] { shield-text-dx: 5; }
    [ldir='W'] { shield-text-dx: -5; }
    [ldir='N'] { shield-text-dy: -5; }
    [ldir='S'] { shield-text-dy: 5; }
    [ldir='NE'] { shield-text-dx: 4; shield-text-dy: -4; }
    [ldir='SE'] { shield-text-dx: 4; shield-text-dy: 4; }
    [ldir='SW'] { shield-text-dx: -4; shield-text-dy: 4; }
    [ldir='NW'] { shield-text-dx: -4; shield-text-dy: -4; }
  }
}

#place_label[zoom>=8][localrank<=3] {
  text-name: @name;
  text-face-name: @sans;
  text-wrap-width: 80;
  text-wrap-before: true;
  text-fill: @text;
  text-halo-fill: @fill1;
  text-halo-radius: 2;
  text-halo-rasterizer: fast;
  text-size: 10;
  text-line-spacing:-2;
  text-margin:25;

  // Cities
  [type='city'][zoom>=8][zoom<=15] {
  	text-face-name: @sans_md;
    text-size: 15;
    text-line-spacing:-7;

    [zoom>=10] { 
      text-size: 17;
      text-wrap-width: 140;
    }
    [zoom>=12] { 
      text-size: 20;
      text-wrap-width: 180;
    }
    // Hide at largest scales:
    [zoom>=16] { text-name: "''"; }
  }
  
  // Towns
  [type='town'] {
    text-size: 12;    
    text-halo-fill: @fill1;
    text-halo-radius: 1.9;
    [zoom>=12] { text-size: 12; }
    [zoom>=14] { text-size: 16; }
    [zoom>=16] { text-size: 22; }
    // Hide at largest scales:
    [zoom>=18] { text-name: "''"; }
  }
}

// Road labels
#road_label[len>2000][zoom>=12],
#road_label[len>1000][zoom>=15] { 
  text-placement: line;
  text-face-name: @sans;
  text-name: @name;
  text-size: 9;
  text-min-distance: 100;
  text-halo-fill: @land;
  text-halo-radius: 1;
  text-fill: @text;
  [zoom>=17] { text-size: 11;}
}