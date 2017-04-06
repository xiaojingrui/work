var AdmZip = require('adm-zip'),
    pth = require('path');

var zip = new AdmZip();
   zip.addLocalFolder(process.argv[2]);
   zip.writeZip( pth.join(process.argv[2], process.argv[3]) );
   process.exit(1);
