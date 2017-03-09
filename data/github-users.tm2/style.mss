#github-users {
  
  marker-comp-op: screen;
  marker-allow-overlap: true;
  marker-line-width: 0;
  marker-fill: #0bf8ee;
  [zoom>=0] { marker-width: [percent] * [percent] * 0.1; }
  [zoom>=2] { marker-width: [percent] * [percent] * 0.2; }
  [zoom>=3] { marker-width: [percent] * [percent] * 0.4; }
  [zoom>=4] { marker-width: [percent] * [percent] * 0.6; }
  [zoom>=5] { marker-width: [percent] * [percent] * 1; }
  [zoom>=6] { marker-width: [percent] * [percent] * 2; }
  [zoom>=7] { marker-width: [percent] * [percent] * 4; }
  [zoom>=8] { marker-width: [percent] * [percent] * 8; }
  [zoom>=9] { marker-width: [percent] * [percent] * 12; }
  [zoom>=10] { marker-width: [percent] * [percent] * 24; }
  [zoom>=11] { marker-width: [percent] * [percent] * 48; }
}

#github-users::label[zoom>=6][percent>=4],
#github-users::label[zoom>=8][percent>=3] {
  text-allow-overlap: true;
  text-size: 14;
  text-name: '[percent]';
  text-face-name: 'Open Sans Regular';
  text-fill: #141414;
}

