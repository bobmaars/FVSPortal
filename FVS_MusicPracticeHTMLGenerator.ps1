<#
Generated using GitHub CoPilot
DIR /S /B "C:\Users\bobma\.copilot\repos\FVSPortal\*.ps1"
Found here
notepad++ "C:\Users\bobma\.copilot\repos\copilot-worktrees\FVSPortal\bobmaars-musical-robot\FVS_MusicPracticeHTMLGenerator.ps1"
#>
# ---------------------------- Below creates all the Voice Group pages ----------------------------
# Last Updated: 23 Sep 2026 03:37 PM
Add-Type -AssemblyName System.Windows.Forms
Write-Host "=== PROCESSING: .\FVS-MusicPracticeHTMLGenerator.ps1  ===" -ForegroundColor Green
$SourcePath = 'C:\$Data\Archie\Seasonal_Music_Semesters\2026_Fall'
$TargetPath = 'C:\$Data\Archie\Seasonal_Music_Semesters\2026_Fall'
Write-Host " Source Path: $SourcePath " -ForegroundColor Yellow
$voiceGroups = @("Alto_1","Alto_2","Barbershop","Baritone","Bass","Fearringtones","Soprano_1","Soprano_2","Tenor_1","Tenor_2","2026_Fall_PDFs")
$groupPages = @{}
$groupCatalog = @()

function ConvertTo-HtmlText { param([AllowNull()][string]$Value) if ($null -eq $Value) { return "" }; [System.Net.WebUtility]::HtmlEncode($Value) }
function ConvertTo-RelativeUrl { param([string]$Path) (($Path -split "/") | ForEach-Object { [Uri]::EscapeDataString($_) }) -join "/" }

$css = @'
:root{--bg:#fff;--fg:#1b1b1b;--header-bg:#f3f2f1;--surface:#fff;--accent:#0078d4;--accent-soft:#c7e0f4;--border:#e1dfdd;--zebra:#f8f8f8;--shadow:0 1px 3px rgba(0,0,0,.12)}
body.dark{--bg:#1b1a19;--fg:#f3f2f1;--header-bg:#2b2a29;--surface:#252423;--accent:#4aa3ff;--accent-soft:#243a5e;--border:#3b3a39;--zebra:#2f2e2d;--shadow:0 1px 3px rgba(0,0,0,.6)}
*{box-sizing:border-box}html{scroll-behavior:smooth}body{margin:0;font-family:system-ui,-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif;background:var(--bg);color:var(--fg)}
header{position:sticky;top:0;z-index:2000;backdrop-filter:blur(8px);background:rgba(0,120,212,.55);color:#fff;padding:10px 16px;display:flex;align-items:center;gap:14px;box-shadow:0 2px 6px rgba(0,0,0,.25)}body.dark header{background:rgba(0,120,212,.3)}
.brand-logo{height:52px;width:auto}.header-title{font-size:18px;font-weight:600;margin-right:auto}.header-actions{display:flex;align-items:center;gap:10px}
button,input[type=search],select{font:inherit;font-size:13px;border:1px solid var(--border);border-radius:4px;padding:6px 9px;background:var(--surface);color:var(--fg)}button{cursor:pointer}button:hover{background:var(--accent-soft);border-color:var(--accent)}
.anchor,.top-index-link{color:#fff;font-size:12px;text-decoration:none;margin-right:8px}.anchor:hover,.top-index-link:hover{text-decoration:underline}.top-index-link{display:inline-block;color:var(--accent);margin:12px 0 0 18px;font-size:13px}
main{width:100%;padding:16px;max-width:1600px;margin:auto}main.layout-grid{display:grid;grid-template-columns:minmax(160px,var(--toc-width,220px)) 6px minmax(0,1fr);gap:0}
#toc{position:sticky;top:84px;height:fit-content;background:var(--surface);border:1px solid var(--border);border-radius:6px;padding:12px;box-shadow:var(--shadow)}#toc h3{margin-top:0;font-size:13px}#toc ul{list-style:none;padding:0;margin:0}#toc li{margin:4px 0}#toc a{color:var(--accent);text-decoration:none;font-size:11px;word-break:break-word}
#toc-resizer{cursor:col-resize;border:0;border-left:1px solid var(--border);border-right:1px solid var(--border);background:var(--accent-soft);min-height:100%}#toc-resizer:hover,#toc-resizer:focus-visible{background:var(--accent)}
.section{background:var(--surface);border:1px solid var(--border);border-radius:4px;margin-bottom:12px;box-shadow:var(--shadow)}.section-header{display:flex;align-items:center;justify-content:space-between;padding:8px 12px;cursor:pointer;border-bottom:1px solid var(--border)}.section-header h2{margin:0;font-size:15px}.chevron{font-size:12px}.section-body{padding:8px 12px 12px}
.table-controls{display:flex;align-items:center;gap:8px;margin-bottom:8px;flex-wrap:wrap}.index-filter-controls{padding:8px 10px;border:2px solid var(--accent);border-radius:6px;background:var(--accent-soft);font-size:12px}.index-filter-controls input,.index-filter-controls select{font-size:12px;padding:4px 7px}
table{width:100%;border-collapse:collapse;font-size:13px}th,td{padding:6px 8px;border-bottom:1px solid var(--border);text-align:left}th{background:var(--header-bg);cursor:pointer;font-weight:600}tbody tr:nth-child(even){background:var(--zebra)}tbody tr:hover{background:var(--accent-soft)}th:focus-visible,button:focus-visible,input:focus-visible,select:focus-visible,a:focus-visible{outline:3px solid #ffb703;outline-offset:2px}
.index-table-wrap,.voice-table-wrap{overflow-x:auto;width:100%}.index-track-table,.voice-track-table{table-layout:fixed;min-width:760px}.index-track-table th:nth-child(1),.index-track-table td:nth-child(1),.voice-track-table th:nth-child(1),.voice-track-table td:nth-child(1){width:19%}.index-track-table th:nth-child(2),.index-track-table td:nth-child(2),.voice-track-table th:nth-child(2),.voice-track-table td:nth-child(2){width:13%}.index-track-table th:nth-child(3),.index-track-table td:nth-child(3),.voice-track-table th:nth-child(3),.voice-track-table td:nth-child(3){width:23%}.index-track-table th:nth-child(4),.index-track-table td:nth-child(4),.voice-track-table th:nth-child(4),.voice-track-table td:nth-child(4){width:45%}.index-track-table audio,.voice-track-table audio{display:block;width:100%;min-width:280px;max-width:none;height:32px}.empty-state{color:var(--accent)}.voice-list{font-size:11px;list-style:none;padding:0}.voice-list a{color:var(--accent)}
footer{background:var(--header-bg);padding:12px 16px;font-size:12px;border-top:1px solid var(--border)}footer a{color:var(--accent)}footer p{margin:6px 0}
@media(max-width:800px){main.layout-grid{grid-template-columns:1fr}#toc{position:static}#toc-resizer{display:none}header{flex-wrap:wrap}.header-actions{margin-left:auto}}@media(max-width:520px){.header-actions{width:100%;justify-content:space-between}}
'@

$js = @'
document.addEventListener("DOMContentLoaded",function(){
 "use strict";
 var body=document.body,theme=document.getElementById("themeToggle"),table=document.getElementById("portalTable");
 function storage(fn){try{return fn()}catch(e){return null}} function applyTheme(v){var dark=v==="dark";body.classList.toggle("dark",dark);if(theme){theme.setAttribute("aria-pressed",String(dark));theme.textContent=dark?"☀️ Light":"🌙 Dark"}}
 applyTheme(storage(function(){return localStorage.getItem("fvs-theme")})==="dark"?"dark":"light");
 if(theme)theme.addEventListener("click",function(){var n=body.classList.contains("dark")?"light":"dark";applyTheme(n);storage(function(){localStorage.setItem("fvs-theme",n)})});
 document.querySelectorAll(".section-header").forEach(function(h){function toggle(){var b=h.parentElement.querySelector(".section-body"),closed=b.hidden;b.hidden=!closed;h.querySelector(".chevron").textContent=closed?"▼":"▲";h.setAttribute("aria-expanded",String(closed))}h.addEventListener("click",toggle);h.addEventListener("keydown",function(e){if(e.key==="Enter"||e.key===" "){e.preventDefault();toggle()}})});
 var resize=document.getElementById("toc-resizer"),layout=document.querySelector("main.layout-grid");if(resize&&layout){var drag=false;resize.addEventListener("pointerdown",function(e){drag=true;resize.setPointerCapture(e.pointerId)});resize.addEventListener("pointermove",function(e){if(!drag||matchMedia("(max-width:800px)").matches)return;var r=layout.getBoundingClientRect();layout.style.setProperty("--toc-width",Math.max(160,Math.min(420,e.clientX-r.left-16))+"px")});resize.addEventListener("pointerup",function(){drag=false});resize.addEventListener("keydown",function(e){var w=parseInt(getComputedStyle(layout).getPropertyValue("--toc-width"),10)||220;if(e.key==="ArrowLeft"||e.key==="ArrowRight"){e.preventDefault();layout.style.setProperty("--toc-width",Math.max(160,Math.min(420,w+(e.key==="ArrowRight"?16:-16)))+"px")}})}
 var toc=document.getElementById("toc-list");if(toc&&!toc.children.length)document.querySelectorAll(".section").forEach(function(s){var t=s.querySelector(".section-header h2");if(t){var li=document.createElement("li"),a=document.createElement("a");a.href="#"+s.id;a.textContent=t.textContent;li.appendChild(a);toc.appendChild(li)}});
 var indexSearch=document.getElementById("indexSearch"),arrangement=document.getElementById("arrangementFilter"),indexEmpty=document.getElementById("indexEmptyState");
 function filterIndex(){if(!indexSearch)return;var term=indexSearch.value.toLowerCase().trim(),pick=arrangement?arrangement.value.toLowerCase():"",count=0;document.querySelectorAll(".index-track-section").forEach(function(s){var group=s.dataset.group.toLowerCase().indexOf(term)!==-1,shown=0;s.querySelectorAll("tbody tr").forEach(function(r){var ok=(group||r.innerText.toLowerCase().indexOf(term)!==-1)&&(!pick||r.dataset.arrangement.toLowerCase()===pick);r.hidden=!ok;if(ok)shown++});s.hidden=!!(term||pick)&&shown===0;if(!s.hidden)count++});if(indexEmpty)indexEmpty.hidden=count!==0}
 if(indexSearch)indexSearch.addEventListener("input",filterIndex);if(arrangement)arrangement.addEventListener("change",filterIndex);
 if(!table)return;var search=document.getElementById("tableSearch"),empty=document.getElementById("emptyState"),heads=table.querySelectorAll("th[data-sort-index]");
 function filterRows(){if(!search)return;var term=search.value.toLowerCase().trim(),n=0;table.tBodies[0].querySelectorAll("tr").forEach(function(r){var show=r.innerText.toLowerCase().indexOf(term)!==-1;r.hidden=!show;if(show)n++});if(empty)empty.hidden=n!==0}
 if(search)search.addEventListener("input",filterRows);heads.forEach(function(h){function sort(){var i=Number(h.dataset.sortIndex),down=h.getAttribute("aria-sort")==="ascending";heads.forEach(function(x){x.removeAttribute("aria-sort")});h.setAttribute("aria-sort",down?"descending":"ascending");Array.from(table.tBodies[0].rows).sort(function(a,b){return a.cells[i].innerText.localeCompare(b.cells[i].innerText,undefined,{numeric:true,sensitivity:"base"})*(down?-1:1)}).forEach(function(r){table.tBodies[0].appendChild(r)})}h.addEventListener("click",sort);h.addEventListener("keydown",function(e){if(e.key==="Enter"||e.key===" "){e.preventDefault();sort()}})})
});
'@

foreach ($voice in $voiceGroups) {
    $voiceDirs = Get-ChildItem -Path $SourcePath -Recurse -Directory | Where-Object { $_.Name -eq $voice }
    foreach ($dir in $voiceDirs) {
        $rows=@();$tracks=@()
        Get-ChildItem -Path $dir.FullName -Filter *.mp3 | Sort-Object Name | ForEach-Object {
            $file=$_.Name;$title="";$arrangement="";$type=""
            if($file -match "^(.*?)\s+(SSATB|SATB|TTBB|TB|TBB|TTB|SSA|SAB|SA|SSAA)\s+-\s+(.*?)\s+-"){$title=$matches[1].Trim();$arrangement=$matches[2];$type=$matches[3]}
            elseif($file -match "^(.*?)\s+(SSATB|SATB|TTBB|TB|TBB|TTB|SSA|SAB|SA|SSAA|Barbershop|Fearringtones)\s+-\s+(.*?).mp3$"){$title=$matches[1].Trim();$arrangement=$matches[2];$type=$matches[3]}
            $relPath=$dir.FullName.Substring($SourcePath.Length+1).Replace("\","/");$url=ConvertTo-RelativeUrl "$relPath/$file";$safe=ConvertTo-HtmlText $url
            $tracks += [pscustomobject]@{Title=$title;Arrangement=$arrangement;Type=$type;RelativeUrl=$url}
            $rows += "<tr><td>$(ConvertTo-HtmlText $title)</td><td>$(ConvertTo-HtmlText $arrangement)</td><td>$(ConvertTo-HtmlText $type)</td><td><audio controls preload=""none""><source src=""$safe"" type=""audio/mpeg"">Your browser does not support audio playback.</audio></td></tr>"
        }
        if(@($rows).Count -gt 0){
            $pageName=$dir.FullName.Substring($SourcePath.Length+1).Replace("\","_")+".html";$display=$dir.FullName.Substring($SourcePath.Length+1).Replace("\"," › ");$groupPages[$pageName]=$display
            $groupCatalog += [pscustomobject]@{PageName=$pageName;DisplayName=$display;Tracks=@($tracks)}
            $html=@"
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>$(ConvertTo-HtmlText "$voice Practice Tracks")</title><style>$css</style></head><body>
<div id="top"></div><header><a href="index.html" aria-label="FVS Practice Portal home"><img class="brand-logo" src="FVSlogo.png" alt="Fearrington Village Singers"></a><span class="header-title">$(ConvertTo-HtmlText "$voice Practice Tracks")</span><div class="header-actions"><a href="#top" class="anchor">▲ Top</a><a href="#bottom" class="anchor">▼ Bottom</a><a href="index.html" class="anchor" aria-label="Go to the FVS Practice Portal index">🏠 Index</a><button id="themeToggle" type="button" aria-pressed="false">🌙 Theme</button><span aria-hidden="true" style="font-size:2rem">♪</span><a href="index.html" class="anchor header-return-link" aria-label="Return to the FVS Practice Portal index">Return to Index</a></div></header>
<a class="top-index-link" href="index.html" aria-label="Back to the FVS Practice Portal index">🏠 Back to Index</a><main><aside id="toc"><h3>Table of Contents</h3><ul id="toc-list"></ul></aside><div><section class="section" id="overview-section"><div class="section-header" role="button" tabindex="0" aria-expanded="true"><h2>🎵 $(ConvertTo-HtmlText "$voice Practice Tracks")</h2><span class="chevron">▼</span></div><div class="section-body"><p>$(ConvertTo-HtmlText $display)</p></div></section><section class="section" id="content-section"><div class="section-header" role="button" tabindex="0" aria-expanded="true"><h2>Practice Tracks</h2><span class="chevron">▼</span></div><div class="section-body"><div class="table-controls"><label for="tableSearch">🔍 Search</label><input id="tableSearch" type="search" placeholder="Title, arrangement, or track type" autocomplete="off"></div><div class="voice-table-wrap"><table id="portalTable" class="voice-track-table"><thead><tr><th data-sort-index="0" role="button" tabindex="0">Title</th><th data-sort-index="1" role="button" tabindex="0">Arrangement</th><th data-sort-index="2" role="button" tabindex="0">Type</th><th>Play</th></tr></thead><tbody>$($rows -join "`n")</tbody></table></div><p id="emptyState" class="empty-state" hidden>No tracks match your search.</p></div></section></div></main>
<footer id="bottom"><p>🎵───────────────────────────────────────🎵</p><p>📘 <strong>Instructions:❓</strong> <a href="instructions.html" target="_blank" rel="noopener">instructions.html</a></p><p>🌐 <a href="https://harmonygrits.blogspot.com" target="_blank" rel="noopener">harmonygrits.blogspot.com</a> | <a href="https://fearringtonvillagesingers.org" target="_blank" rel="noopener">fearringtonvillagesingers.org</a></p><p>📧 <a href="mailto:info@fearringtonvillagesingers.org">info@fearringtonvillagesingers.org</a></p><p>🕒 <strong>Updated:</strong> Last Updated: 12 Sep 2026 10:02 AM</p><p>🖋️ <strong>Author:</strong> Bob Maarschalkerweerd (R) 2026</p><p>📬 <strong>Contact:</strong> <a href="mailto:BobMaars@gmail.com">BobMaars@gmail.com</a></p><p><a href="#top">⬆️ Back to Top</a> | <a href="index.html">🏠 Return to Index</a></p></footer><script>$js</script></body></html>
"@
            Set-Content -Path (Join-Path $TargetPath $pageName) -Value $html -Encoding UTF8
            Write-Host "✅ Created Page: $TargetPath\$pageName" -ForegroundColor Green
        }
    }
}

$indexRows=$groupPages.GetEnumerator()|Sort-Object Value|ForEach-Object{"<li><a href=""$(ConvertTo-HtmlText (ConvertTo-RelativeUrl $_.Key))"">🎶 $(ConvertTo-HtmlText $_.Value)</a></li>"}
$arrangements=@($groupCatalog|ForEach-Object{$_.Tracks}|Where-Object{$_.Arrangement}|Select-Object -ExpandProperty Arrangement -Unique|Sort-Object)
$options=($arrangements|ForEach-Object{"<option value=""$(ConvertTo-HtmlText $_)"">$(ConvertTo-HtmlText $_)</option>"})-join "`n"
$sections=foreach($group in ($groupCatalog|Sort-Object DisplayName)){
    $id="voice-"+([regex]::Replace($group.PageName.ToLowerInvariant(),"[^a-z0-9]+","-").Trim("-"))
    $rows=foreach($track in ($group.Tracks|Sort-Object Title,Arrangement,Type)){$u=ConvertTo-HtmlText $track.RelativeUrl;"<tr data-arrangement=""$(ConvertTo-HtmlText $track.Arrangement)""><td>$(ConvertTo-HtmlText $track.Title)</td><td>$(ConvertTo-HtmlText $track.Arrangement)</td><td>$(ConvertTo-HtmlText $track.Type)</td><td><audio controls preload=""none""><source src=""$u"" type=""audio/mpeg"">Your browser does not support audio playback.</audio></td></tr>"}
    "<section class=""section index-track-section"" id=""$id"" data-group=""$(ConvertTo-HtmlText $group.DisplayName)""><div class=""section-header"" role=""button"" tabindex=""0"" aria-expanded=""false""><h2>$(ConvertTo-HtmlText $group.DisplayName)</h2><span class=""chevron"">▲</span></div><div class=""section-body"" hidden><div class=""index-table-wrap""><table class=""index-track-table""><thead><tr><th>Song name</th><th>Arrangement</th><th>Voice type / track</th><th>Audio / Play</th></tr></thead><tbody>$($rows -join "`n")</tbody></table></div></div></section>"
}
$indexHtml=@"
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>FVS Practice Portal – Fall 2025</title><style>$css</style></head><body>
<div id="top"></div><header><a href="index.html" aria-label="FVS Practice Portal home"><img class="brand-logo" src="FVSlogo.png" alt="Fearrington Village Singers"></a><span class="header-title">FVS Practice Portal</span><div class="header-actions"><a href="#top" class="anchor">▲ Top</a><a href="#bottom" class="anchor">▼ Bottom</a><a href="index.html" class="anchor" aria-label="Go to the FVS Practice Portal index">🏠 Index</a><button id="themeToggle" type="button" aria-pressed="false">🌙 Theme</button><span aria-hidden="true" style="font-size:2rem">♪</span><a href="index.html" class="anchor header-return-link" aria-label="Return to the FVS Practice Portal index">Return to Index</a></div></header>
<main class="layout-grid"><aside id="toc"><h3>Voice-group pages</h3><ul id="toc-list">$($indexRows -join "`n")</ul></aside><div id="toc-resizer" role="separator" tabindex="0" aria-label="Resize voice-group links column" aria-orientation="vertical"></div><div><section class="section" id="welcome-section"><div class="section-header" role="button" tabindex="0" aria-expanded="true"><h2>🎶 Fearrington Village Singers Practice Portal</h2><span class="chevron">▼</span></div><div class="section-body"><div class="table-controls index-filter-controls"><label for="indexSearch">🔍 Filter songs</label><input id="indexSearch" type="search" placeholder="Song, group, voice type" autocomplete="off"><label for="arrangementFilter">Arrangement</label><select id="arrangementFilter"><option value="">All arrangements</option>$options</select></div><p id="indexEmptyState" class="empty-state" hidden>No matching voice groups or tracks.</p></div></section>$($sections -join "`n")</div></main>
<footer id="bottom"><p>🎵───────────────────────────────────────🎵</p><p>📘 <strong>Instructions:❓</strong> <a href="instructions.html" target="_blank" rel="noopener">instructions.html</a></p><p>🌐 <a href="https://harmonygrits.blogspot.com" target="_blank" rel="noopener">harmonygrits.blogspot.com</a> | <a href="https://fearringtonvillagesingers.org" target="_blank" rel="noopener">fearringtonvillagesingers.org</a></p><p>📧 <a href="mailto:info@fearringtonvillagesingers.org">info@fearringtonvillagesingers.org</a></p><p>🕒 <strong>Updated:</strong> Last Updated: 23 Sep 2026 03:36 PM</p><p>🖋️ <strong>Author:</strong> Bob Maarschalkerweerd (R) 2026</p><p>📬 <strong>Contact:</strong> <a href="mailto:BobMaars@gmail.com">BobMaars@gmail.com</a></p><p><a href="#top">⬆️ Back to Top</a> | <a href="index.html">🏠 Return to Index</a></p></footer><script>$js</script></body></html>
<!-- ( "Developer Notes: ) -->
<!-- ( "C:\Program Files\WinRAR\WinRAR.exe" a -ep1 "C:\$Data\Archie\Seasonal_Music_Semesters\2026_Fall\2026_Fall_Portal.zip" "C:\$Data\Archie\Seasonal_Music_Semesters\2026_Fall\*.*" ) -->
<!-- ( "C:\Program Files\WinRAR\WinRAR.exe" a -ep1 "G:\My Drive\Archie\Seasonal_Music_Semesters\2026_Fall\2026_Fall_Portal.zip" "C:\$Data\Archie\Seasonal_Music_Semesters\2026_Fall\*.*" ) -->
<!-- (Robocopy /MT:12 /R:5 /W:10 /MIR /ZB /X /COPY:DAT "C:\Fearrington_Village_Singers_Archie\Seasonal_Music_Semesters\2026_Fall" "G:\My Drive\Archie\Seasonal_Music_Semesters\2026_Fall" /TIMFIX /FFT /NP /NC /NDL /IF /TS /TEE /LOG+:%odl%\%ComputerName%_RoboCopy_Mirror2026_Fall.log) -->
"@
Set-Content -Path (Join-Path $SourcePath "index.html") -Value $indexHtml -Encoding UTF8
Write-Host "🎯 Master index created: $SourcePath\index.html"
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
