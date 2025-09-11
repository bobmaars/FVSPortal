<#
🛠️ PowerShell Script: Practice Page Generator with Master Index
.\FVS_MusicPracticeHTMLGenerator.ps1
Last Updated: 09 Sep 2025 12:48 PM - Created
Last Updated: 09 Sep 2025 12:22 PM - Toggle button moved and default to light
Last Updated: 09 Sep 2025 01:03 PM - Created .css Style Sheets for this
Last Updated: 09 Sep 2025 02:47 PM - Updated Style sheets
Last Updated: 10 Sep 2025 03:18 PM - Updated Footer
Last Updated: 10 Sep 2025 04:19 PM - Updated - cleanup code
- 🔍 Recursively scans all voice group folders (including nested ones like Fearringtones)
- 🎶 Parses .mp3 filenames to extract metadata
- 🧱 Generates one HTML page per voice group
- 🧭 Builds a master index.html with links to each voice group’s page

🧠 What This Script Does
- Recursively finds all voice group folders (including Fearringtones)
- Generates one HTML page per group with playable, sortable tables
- Builds a clean index.html with links to each group’s page
- Uses emoji-coded feedback and modular naming for clarity
• 	🖼️ A logo at the top
• 	🔗 A “Return to Index” link
• 	⬆️ A “Back to Top” anchor
• 	📍 Navigation links at both top and bottom
✅ Changes to Apply
1. Move the Toggle Button into the Header
Place it inside the same flex container as your logo and index link.
2. Default to Light Mode
Change <body class="dark"> to <body> and update the toggle logic to add .dark only when clicked.
🔧 Updated Header Block (for both voice pages and index)
#>
# ---------------------------- Below creates all the Voice Group pages ----------------------------
Add-Type -AssemblyName System.Windows.Forms
$rootPath = "C:\Fearrington_Village_Singers_Archie\Seasonal_Music_Semesters\2025_Fall"
$voiceGroups = @("Alto 1", "Alto 2", "Baritone", "Bass", "Soprano 1", "Soprano 2", "Tenor 1", "Tenor 2")
$groupPages = @{}

# 🔁 Recursively scan for voice group folders
foreach ($voice in $voiceGroups) {
    $voiceDirs = Get-ChildItem -Path $rootPath -Recurse -Directory | Where-Object { $_.Name -eq $voice }

    foreach ($dir in $voiceDirs) {
        $rows = @()
        Get-ChildItem -Path $dir.FullName -Filter *.mp3 | ForEach-Object {
            $file = $_.Name
            $title, $arrangement, $type = $null

            if ($file -match "^(.*?)\s+(SATB|TTBB)\s+-\s+(.*?)\s+-") {
                $title = $matches[1].Trim()
                $arrangement = $matches[2]
                $type = $matches[3]
            } elseif ($file -match "^(.*?)\s+(SATB|TTBB)\s+-\s+(.*?).mp3$") {
                $title = $matches[1].Trim()
                $arrangement = $matches[2]
                $type = $matches[3]
            }

            $relPath = $dir.FullName.Substring($rootPath.Length + 1).Replace("\", "/")
            $rows += @"
<tr>
  <td>$title</td>
  <td>$arrangement</td>
  <td>$type</td>
  <td><audio controls><source src='$relPath/$file' type='audio/mpeg'></audio></td>
</tr>
"@
        }

        if ($rows.Count -gt 0) {
            $pageName = $dir.FullName.Substring($rootPath.Length + 1).Replace("\", "_") + ".html"
            $groupPages[$pageName] = $dir.FullName.Substring($rootPath.Length + 1).Replace("\", " › ")

            $html = @"
<!DOCTYPE html>
<html>
<!-- (This Page was created by Bob Maarschalkerweerd - BobMaars@gmail.com - Last Updated: 09 Sep 2025 01:12 PM) -->
<!-- (Version 1.05) -->
<head>
  <meta charset='UTF-8'>
  <link rel="stylesheet" href="portalTable.css?v=1.0">
  <title>$voice Practice Tracks</title>
  <script src="sorttable.js"></script>
</head>
<!-- (Set Default Theme color to Light - Where Dark is more relaxing and better for eyes) -->
<!-- body class="dark" -->
<body>
<a name="top"></a>
<div style="display: flex; align-items: center; justify-content: space-between; align-items: center;">
  <img src="FVSlogo.png" alt="FVS Logo" style="height: 60px;">
  <div style="display: flex; gap: 20px; align-items: center;">
    <a href="index.html" style="font-size: 1em; color: #0078d7; text-decoration: none;">🏠 Return to Index</a>
    <button onclick="toggleTheme()" style="background-color: #0078d7; color: white; border: none; padding: 6px 12px; border-radius: 5px; cursor: pointer;">🌓 Toggle Theme</button>
  </div>
</div>
<script>
  function toggleTheme() {
    document.body.classList.toggle("dark");
  }
</script>

<h1>🎵 $voice Practice Tracks – $($groupPages[$pageName])</h1>
<label for="searchBox"><strong>🔍 Search:</strong></label>
<input type="text" id="searchBox" placeholder="Type to filter songs..." style="margin-left: 10px; padding: 4px; width: 300px;">
<table class="sortable">
<thead>
  <tr>
    <th title="Click to sort">Title</th>
    <th title="Click to sort">Arrangement</th>
    <th title="Click to sort">Type</th>
    <th title="Click to sort">Play</th>
  </tr>
</thead>
<tbody>
$($rows -join "`n")
  </tbody>
</table>

<!-- (Keep the rest of your footer content here as-is) -->
<footer>
  <p class="divider">🎵───────────────────────────────────────🎵</p>
  <p>📘 <strong>Instructions:❓</strong> <a href="instructions.html" target="_blank">instructions.html</a></p>
  <p>🌐 <strong>URLs:</strong> <a href="https://harmonygrits.blogspot.com" target="_blank">harmonygrits.blogspot.com</a> | <a href="https://fearringtonvillagesingers.org" target="_blank">fearringtonvillagesingers.org</a></p>
  <p>📧 <strong>Email:</strong> <a href="mailto:info@fearringtonvillagesingers.org">info@fearringtonvillagesingers.org</a></p>
  <p>🕒 <strong>Updated:</strong> Last Updated: 10 Sep 2025 04:19 PMs</p>
  <p>🖋️ <strong>Author:</strong> Bob Maarschalkerweerd (R) 2025</p>
  <p>📬 <strong>Contact:</strong> <a href="mailto:BobMaars@gmail.com">BobMaars@gmail.com</a></p>
  <p style="margin-top: 0.8em;">
    ⬆️ <a href="#top">Back to Top</a> | 🏠 <a href="index.html">Return to Index</a>
  </p>
</footer>

<script>
  document.getElementById("searchBox").addEventListener("keyup", function() {
    const filter = this.value.toLowerCase();
    const rows = document.querySelectorAll("table.sortable tbody tr");

    rows.forEach(row => {
      const text = row.textContent.toLowerCase();
      row.style.display = text.includes(filter) ? "" : "none";
    });
  });
</script>
<script>
  function toggleTheme() {
    document.body.classList.toggle("dark");
  }

  document.getElementById("searchBox").addEventListener("keyup", function() {
    const filter = this.value.toLowerCase();
    const rows = document.querySelectorAll("table.sortable tbody tr");

    rows.forEach(row => {
      const text = row.textContent.toLowerCase();
      row.style.display = text.includes(filter) ? "" : "none";
    });
  });
</script>
</body>
</html>
"@
            $outputPath = Join-Path $rootPath $pageName
            Set-Content -Path $outputPath -Value $html -Encoding UTF8
            Write-Host "✅ Generated: $outputPath"
        }
    }
}
<#================================= Build the Master Index =================================
 🧭 Build Master Index - ✅ Refactored $indexHtml with Theme Toggle
 ---------------------------- Below creates the index.html page --------------------------#>
$indexRows = $groupPages.GetEnumerator() |
    Sort-Object Value |
    ForEach-Object {
        "<li style='margin-bottom: 8px; font-size: 1.05em;'><a href='$($_.Key)'>🎶 $($_.Value)</a></li>"
    }
    
$timestamp = Get-Date -Format "dd MMM yyyy hh:mm tt"

$indexHtml = @"
<!DOCTYPE html>
<html>
<!-- (This Page was created by Bob Maarschalkerweerd - BobMaars@gmail.com - Last Updated: 09 Sep 2025 01:12 PM) -->
<!-- (Version 1.05) -->

<head>
  <meta charset='UTF-8'>
  <link rel="stylesheet" href="portal.css?v=1.0">
  <title>FVS Practice Portal – Fall 2025</title>
</head>
  <!-- (Set Default Theme color to Light - Where Dark is more relaxing and better for eyes) --- body class="dark" -->
<body>
<a name="top"></a>
<div style="display: flex; align-items: center; justify-content: space-between; align-items: center;">
  <img src="FVSlogo.png" alt="FVS Logo" style="height: 60px;">
  <div style="display: flex; gap: 13px; align-items: center;">
    <a href="index.html" style="font-size: 1em; color: #0078d7; text-decoration: none;">🏠 Return to Index</a>
    <button onclick="toggleTheme()" style="background-color: #0078d7; color: white; border: none; padding: 6px 12px; border-radius: 5px; cursor: pointer;">🌓 Toggle Theme</button>
  </div>
</div>
<script>
  function toggleTheme() {
    document.body.classList.toggle("dark");
  }
</script>

<h1>🎶 Fearrington Village Singers Practice Portal</h1>
<p>Select your voice group below to access rehearsal tracks:</p>
<ul style="margin-top: 10px; padding-left: 0; list-style-type: none;">
$($indexRows -join "`n")
</ul>

<!-- (Keep the rest of your footer content here as-is) -->
<footer>
  <p class="divider">🎵───────────────────────────────────────🎵</p>
  <p>📘 <strong>Instructions:❓</strong> <a href="instructions.html" target="_blank">instructions.html</a></p>
  <p>🌐 <strong>URLs:</strong> <a href="https://harmonygrits.blogspot.com" target="_blank">harmonygrits.blogspot.com</a> | <a href="https://fearringtonvillagesingers.org" target="_blank">fearringtonvillagesingers.org</a></p>
  <p>📧 <strong>Email:</strong> <a href="mailto:info@fearringtonvillagesingers.org">info@fearringtonvillagesingers.org</a></p>
  <p>🕒 <strong>Updated:</strong> Last Updated: 10 Sep 2025 04:19 PMs</p>
  <p>🖋️ <strong>Author:</strong> Bob Maarschalkerweerd (R) 2025</p>
  <p>📬 <strong>Contact:</strong> <a href="mailto:BobMaars@gmail.com">BobMaars@gmail.com</a></p>
  <p style="margin-top: 0.8em;">
    ⬆️ <a href="#top">Back to Top</a> | 🏠 <a href="index.html">Return to Index</a>
  </p>
</footer>

</body>
</html>
<!-- ( "Developer Notes: ) -->
<!-- ( "C:\Program Files\WinRAR\WinRAR.exe" a -ep1 "C:\$Data\Archie\Seasonal_Music_Semesters\2025_Fall\2025_Fall_Portal.zip" "C:\$Data\Archie\Seasonal_Music_Semesters\2025_Fall\*.*" ) -->
<!-- ( "C:\Program Files\WinRAR\WinRAR.exe" a -ep1 "G:\My Drive\Archie\Seasonal_Music_Semesters\2025_Fall\2025_Fall_Portal.zip"  "C:\$Data\Archie\Seasonal_Music_Semesters\2025_Fall\*.*" ) -->
<!-- (Robocopy /MT:12 /R:5 /W:10 /MIR /ZB /X /COPY:DAT "C:\Fearrington_Village_Singers_Archie\Seasonal_Music_Semesters\2025_Fall" "G:\My Drive\Archie\Seasonal_Music_Semesters\2025_Fall" /TIMFIX /FFT /NP /NC /NDL /IF /TS /TEE /LOG+:%odl%\%ComputerName%_RoboCopy_Mirror2025_Fall.log) -->

"@

Set-Content -Path (Join-Path $rootPath "index.html") -Value $indexHtml -Encoding UTF8
Write-Host "🎯 Master index created: $rootPath\index.html"

<#
• 	🧠 Smart environment propagation
• 	📝 Resilient transcript logging
• 	📂 Dynamic startup location handling
• 	🧭 Host-aware window titling
• 	🧰 Alias safety with emoji-coded feedback
• 	🎨 PSReadLine theming and UTF-8 normalization
• 	📦 Module imports with fallback diagnostics
• 	🧪 Symbolic variables and diagnostic overlays
• 	🧠 Session metadata initialization with path validation
• 	🔐 Elevation checks and script root resolution
• 	🧵 Argument completers and startup timer

#>