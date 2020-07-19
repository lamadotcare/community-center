# Community Center
A complete self-hosted application suite for organizing and supporting mutual aid.

# Step 1: Login to your server
Using an SSH terminal such as PuTTY or MobaXTerm, login to your server with SSH.

# Step 2: Fetch the foundation.sh script and check its hash
```
# wget https://raw.githubusercontent.com/lamadotcare/community-center/master/foundation.sh
# wget https://raw.githubusercontent.com/lamadotcare/community-center/master/foundation.sh.sha256
# sha256sum -c foundation.sh.sha256
```
You should see output like this:
```
foundation.sh: OK
```
DO NOT trust the script if you see output that looks like this:
```
foundation.sh: FAILED
sha256sum: WARNING: 1 of 1 computed checksums did NOT match
```
Open an issue and tell us immediately by clicking on the "(!) Issues" tab (next to "<> Code" ) and then clicking on
 the green "New issue" button.  This will alert us to the problem so we can take steps to verify the integrity of the
  software.

# Step 3: Run the foundation.sh script
```
# sudo bash foundation.sh 
```

# Step 4: Run the construction.sh script
```
# sudo bash construction.sh
```

# Step 5: Check out your community center
