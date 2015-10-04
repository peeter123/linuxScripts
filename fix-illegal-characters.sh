 #!/bin/sh

 find $1 -type f -print0 | perl -n0e '$new = $_; if($new =~ s/[^[:ascii:]]/_/g) { print("Renaming $_ to $new\n"); rename($_, $new); }'
