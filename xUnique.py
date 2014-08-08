



<!DOCTYPE html>
<html lang="en" class="   ">
  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# object: http://ogp.me/ns/object# article: http://ogp.me/ns/article# profile: http://ogp.me/ns/profile#">
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Language" content="en">
    
    
    <title>xUnique/xUnique.py at master · truebit/xUnique</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub">
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub">
    <link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-114.png">
    <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114.png">
    <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-144.png">
    <link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144.png">
    <meta property="fb:app_id" content="1401488693436528">

      <meta content="@github" name="twitter:site" /><meta content="summary" name="twitter:card" /><meta content="truebit/xUnique" name="twitter:title" /><meta content="xUnique - merge Xcode project file is so easy" name="twitter:description" /><meta content="https://avatars0.githubusercontent.com/u/754906?v=2&amp;s=400" name="twitter:image:src" />
<meta content="GitHub" property="og:site_name" /><meta content="object" property="og:type" /><meta content="https://avatars0.githubusercontent.com/u/754906?v=2&amp;s=400" property="og:image" /><meta content="truebit/xUnique" property="og:title" /><meta content="https://github.com/truebit/xUnique" property="og:url" /><meta content="xUnique - merge Xcode project file is so easy" property="og:description" />

    <link rel="assets" href="https://assets-cdn.github.com/">
    <link rel="conduit-xhr" href="https://ghconduit.com:25035">
    <link rel="xhr-socket" href="/_sockets">

    <meta name="msapplication-TileImage" content="/windows-tile.png">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="selected-link" value="repo_source" data-pjax-transient>
      <meta name="google-analytics" content="UA-3769691-2">

    <meta content="collector.githubapp.com" name="octolytics-host" /><meta content="collector-cdn.github.com" name="octolytics-script-host" /><meta content="github" name="octolytics-app-id" /><meta content="6ABB634A:552F:6F63307:53E44323" name="octolytics-dimension-request_id" /><meta content="1277364" name="octolytics-actor-id" /><meta content="justzt" name="octolytics-actor-login" /><meta content="1f806ee17b29c393ab73718d6cce298cbca118b1ada3da924b87ce43d17f56d7" name="octolytics-actor-hash" />
    

    
    
    <link rel="icon" type="image/x-icon" href="https://assets-cdn.github.com/favicon.ico">


    <meta content="authenticity_token" name="csrf-param" />
<meta content="UXAMYfdJ17TIvohVaR1JGaIsY2bByq+gqorCAYNA3J8rIiDIs5k/kLtrUDmgGjK7gbBWr3xk7UcsBTEmlY8d7g==" name="csrf-token" />

    <link href="https://assets-cdn.github.com/assets/github-7d0cf5969c6b0c04ea48a7dc937648fd0eb9c4a2.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://assets-cdn.github.com/assets/github2-c47807f6c282e07774df77d23061aecf5fe36c2a.css" media="all" rel="stylesheet" type="text/css" />
    


    <meta http-equiv="x-pjax-version" content="b601b4324050953c93a3386f420a009a">

      
  <meta name="description" content="xUnique - merge Xcode project file is so easy">


  <meta content="754906" name="octolytics-dimension-user_id" /><meta content="truebit" name="octolytics-dimension-user_login" /><meta content="22507725" name="octolytics-dimension-repository_id" /><meta content="truebit/xUnique" name="octolytics-dimension-repository_nwo" /><meta content="true" name="octolytics-dimension-repository_public" /><meta content="false" name="octolytics-dimension-repository_is_fork" /><meta content="22507725" name="octolytics-dimension-repository_network_root_id" /><meta content="truebit/xUnique" name="octolytics-dimension-repository_network_root_nwo" />
  <link href="https://github.com/truebit/xUnique/commits/master.atom" rel="alternate" title="Recent Commits to xUnique:master" type="application/atom+xml">

  </head>


  <body class="logged_in  env-production  vis-public page-blob">
    <a href="#start-of-content" tabindex="1" class="accessibility-aid js-skip-to-content">Skip to content</a>
    <div class="wrapper">
      
      
      
      


      <div class="header header-logged-in true">
  <div class="container clearfix">

    <a class="header-logo-invertocat" href="https://github.com/" aria-label="Homepage">
  <span class="mega-octicon octicon-mark-github"></span>
</a>


        <a href="/notifications" aria-label="You have no unread notifications" class="notification-indicator tooltipped tooltipped-s" data-hotkey="g n">
        <span class="mail-status all-read"></span>
</a>

      <div class="command-bar js-command-bar  in-repository">
          <form accept-charset="UTF-8" action="/search" class="command-bar-form" id="top_search_form" method="get"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>

<div class="commandbar">
  <span class="message"></span>
  <input type="text" data-hotkey="s, /" name="q" id="js-command-bar-field" placeholder="Search or type a command" tabindex="1" autocapitalize="off"
    
    data-username="justzt"
    data-repo="truebit/xUnique"
  >
  <div class="display hidden"></div>
</div>

    <input type="hidden" name="nwo" value="truebit/xUnique">

    <div class="select-menu js-menu-container js-select-menu search-context-select-menu">
      <span class="minibutton select-menu-button js-menu-target" role="button" aria-haspopup="true">
        <span class="js-select-button">This repository</span>
      </span>

      <div class="select-menu-modal-holder js-menu-content js-navigation-container" aria-hidden="true">
        <div class="select-menu-modal">

          <div class="select-menu-item js-navigation-item js-this-repository-navigation-item selected">
            <span class="select-menu-item-icon octicon octicon-check"></span>
            <input type="radio" class="js-search-this-repository" name="search_target" value="repository" checked="checked">
            <div class="select-menu-item-text js-select-button-text">This repository</div>
          </div> <!-- /.select-menu-item -->

          <div class="select-menu-item js-navigation-item js-all-repositories-navigation-item">
            <span class="select-menu-item-icon octicon octicon-check"></span>
            <input type="radio" name="search_target" value="global">
            <div class="select-menu-item-text js-select-button-text">All repositories</div>
          </div> <!-- /.select-menu-item -->

        </div>
      </div>
    </div>

  <span class="help tooltipped tooltipped-s" aria-label="Show command bar help">
    <span class="octicon octicon-question"></span>
  </span>


  <input type="hidden" name="ref" value="cmdform">

</form>
        <ul class="top-nav">
          <li class="explore"><a href="/explore">Explore</a></li>
            <li><a href="https://gist.github.com">Gist</a></li>
            <li><a href="/blog">Blog</a></li>
          <li><a href="https://help.github.com">Help</a></li>
        </ul>
      </div>

    
<ul id="user-links">
  <li>
    <a href="/justzt" class="name">
      <img alt="justzt" data-user="1277364" height="20" src="https://avatars3.githubusercontent.com/u/1277364?v=2&amp;s=40" width="20" /> justzt
    </a>
  </li>

  <li class="new-menu dropdown-toggle js-menu-container">
    <a href="#" class="js-menu-target tooltipped tooltipped-s" aria-label="Create new...">
      <span class="octicon octicon-plus"></span>
      <span class="dropdown-arrow"></span>
    </a>

    <div class="new-menu-content js-menu-content">
    </div>
  </li>

  <li>
    <a href="/settings/profile" id="account_settings"
      class="tooltipped tooltipped-s"
      aria-label="Account settings ">
      <span class="octicon octicon-tools"></span>
    </a>
  </li>
  <li>
    <form accept-charset="UTF-8" action="/logout" class="logout-form" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="WYBzGBJRRwo4QX+7UN0CMnTK92jjPKw0sovh38pMErgc9JAkoBpz2QEKGacIJf5tsasJaeZBwWxcVbbKdvuQpw==" /></div>
      <button class="sign-out-button tooltipped tooltipped-s" aria-label="Sign out">
        <span class="octicon octicon-sign-out"></span>
      </button>
</form>  </li>

</ul>

<div class="js-new-dropdown-contents hidden">
  
<ul class="dropdown-menu">
  <li>
    <a href="/new"><span class="octicon octicon-repo"></span> New repository</a>
  </li>
  <li>
    <a href="https://porter.github.com/new"><span class="octicon octicon-move-right"></span> Import repository</a>
  </li>
  <li>
    <a href="/organizations/new"><span class="octicon octicon-organization"></span> New organization</a>
  </li>


    <li class="section-title">
      <span title="truebit/xUnique">This repository</span>
    </li>
      <li>
        <a href="/truebit/xUnique/issues/new"><span class="octicon octicon-issue-opened"></span> New issue</a>
      </li>
</ul>

</div>


    
  </div>
</div>

      

        


      <div id="start-of-content" class="accessibility-aid"></div>
          <div class="site" itemscope itemtype="http://schema.org/WebPage">
    <div id="js-flash-container">
      
    </div>
    <div class="pagehead repohead instapaper_ignore readability-menu">
      <div class="container">
        
<ul class="pagehead-actions">

    <li class="subscription">
      <form accept-charset="UTF-8" action="/notifications/subscribe" class="js-social-container" data-autosubmit="true" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="3+b2YeZ00hBBF8zkhApSCeZiJVrR33C7FfyxaxcZNlOCz8ctN70cfA9xg+DyFNbE2q6V27E7HUVhjdVPhh0Dcw==" /></div>  <input id="repository_id" name="repository_id" type="hidden" value="22507725" />

    <div class="select-menu js-menu-container js-select-menu">
      <a class="social-count js-social-count" href="/truebit/xUnique/watchers">
        10
      </a>
      <a href="/truebit/xUnique/subscription"
        class="minibutton select-menu-button with-count js-menu-target" role="button" tabindex="0" aria-haspopup="true">
        <span class="js-select-button">
          <span class="octicon octicon-eye"></span>
          Watch
        </span>
      </a>

      <div class="select-menu-modal-holder">
        <div class="select-menu-modal subscription-menu-modal js-menu-content" aria-hidden="true">
          <div class="select-menu-header">
            <span class="select-menu-title">Notifications</span>
            <span class="octicon octicon-x js-menu-close" role="button" aria-label="Close"></span>
          </div> <!-- /.select-menu-header -->

          <div class="select-menu-list js-navigation-container" role="menu">

            <div class="select-menu-item js-navigation-item selected" role="menuitem" tabindex="0">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <div class="select-menu-item-text">
                <input checked="checked" id="do_included" name="do" type="radio" value="included" />
                <h4>Not watching</h4>
                <span class="description">Be notified when participating or @mentioned.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="octicon octicon-eye"></span>
                  Watch
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

            <div class="select-menu-item js-navigation-item " role="menuitem" tabindex="0">
              <span class="select-menu-item-icon octicon octicon octicon-check"></span>
              <div class="select-menu-item-text">
                <input id="do_subscribed" name="do" type="radio" value="subscribed" />
                <h4>Watching</h4>
                <span class="description">Be notified of all conversations.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="octicon octicon-eye"></span>
                  Unwatch
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

            <div class="select-menu-item js-navigation-item " role="menuitem" tabindex="0">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <div class="select-menu-item-text">
                <input id="do_ignore" name="do" type="radio" value="ignore" />
                <h4>Ignoring</h4>
                <span class="description">Never be notified.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="octicon octicon-mute"></span>
                  Stop ignoring
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

          </div> <!-- /.select-menu-list -->

        </div> <!-- /.select-menu-modal -->
      </div> <!-- /.select-menu-modal-holder -->
    </div> <!-- /.select-menu -->

</form>
    </li>

  <li>
    
  <div class="js-toggler-container js-social-container starring-container ">

    <form accept-charset="UTF-8" action="/truebit/xUnique/unstar" class="js-toggler-form starred js-unstar-button" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="Pnr2YaOAg7/hrVnIyLOIRXPQVtWNPMEq3imZJrDAxa/cQaqaAOu9mQXOCPRn2tPAtdjaQmULUwd4OZIonOeVoQ==" /></div>
      <button
        class="minibutton with-count js-toggler-target star-button"
        aria-label="Unstar this repository" title="Unstar truebit/xUnique">
        <span class="octicon octicon-star"></span>
        Unstar
      </button>
        <a class="social-count js-social-count" href="/truebit/xUnique/stargazers">
          132
        </a>
</form>
    <form accept-charset="UTF-8" action="/truebit/xUnique/star" class="js-toggler-form unstarred js-star-button" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="CaKPSkfFYsbOVIdUqe55aCLdyv446lHQL0s6GNHdzie1UektFHmhBhWm7lO2PAfXJ28ffRQLT92nuMZjkhBVWQ==" /></div>
      <button
        class="minibutton with-count js-toggler-target star-button"
        aria-label="Star this repository" title="Star truebit/xUnique">
        <span class="octicon octicon-star"></span>
        Star
      </button>
        <a class="social-count js-social-count" href="/truebit/xUnique/stargazers">
          132
        </a>
</form>  </div>

  </li>


        <li>
          <a href="/truebit/xUnique/fork" class="minibutton with-count js-toggler-target fork-button lighter tooltipped-n" title="Fork your own copy of truebit/xUnique to your account" aria-label="Fork your own copy of truebit/xUnique to your account" rel="facebox nofollow">
            <span class="octicon octicon-repo-forked"></span>
            Fork
          </a>
          <a href="/truebit/xUnique/network" class="social-count">1</a>
        </li>

</ul>

        <h1 itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="entry-title public">
          <span class="mega-octicon octicon-repo"></span>
          <span class="author"><a href="/truebit" class="url fn" itemprop="url" rel="author"><span itemprop="title">truebit</span></a></span><!--
       --><span class="path-divider">/</span><!--
       --><strong><a href="/truebit/xUnique" class="js-current-repository js-repo-home-link">xUnique</a></strong>

          <span class="page-context-loader">
            <img alt="" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
          </span>

        </h1>
      </div><!-- /.container -->
    </div><!-- /.repohead -->

    <div class="container">
      <div class="repository-with-sidebar repo-container new-discussion-timeline  ">
        <div class="repository-sidebar clearfix">
            
<div class="sunken-menu vertical-right repo-nav js-repo-nav js-repository-container-pjax js-octicon-loaders" data-issue-count-url="/truebit/xUnique/issues/counts">
  <div class="sunken-menu-contents">
    <ul class="sunken-menu-group">
      <li class="tooltipped tooltipped-w" aria-label="Code">
        <a href="/truebit/xUnique" aria-label="Code" class="selected js-selected-navigation-item sunken-menu-item" data-hotkey="g c" data-pjax="true" data-selected-links="repo_source repo_downloads repo_commits repo_releases repo_tags repo_branches /truebit/xUnique">
          <span class="octicon octicon-code"></span> <span class="full-word">Code</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

        <li class="tooltipped tooltipped-w" aria-label="Issues">
          <a href="/truebit/xUnique/issues" aria-label="Issues" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g i" data-selected-links="repo_issues repo_labels repo_milestones /truebit/xUnique/issues">
            <span class="octicon octicon-issue-opened"></span> <span class="full-word">Issues</span>
            <span class="js-issue-replace-counter"></span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>        </li>

      <li class="tooltipped tooltipped-w" aria-label="Pull Requests">
        <a href="/truebit/xUnique/pulls" aria-label="Pull Requests" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g p" data-selected-links="repo_pulls /truebit/xUnique/pulls">
            <span class="octicon octicon-git-pull-request"></span> <span class="full-word">Pull Requests</span>
            <span class="js-pull-replace-counter"></span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>


        <li class="tooltipped tooltipped-w" aria-label="Wiki">
          <a href="/truebit/xUnique/wiki" aria-label="Wiki" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g w" data-selected-links="repo_wiki /truebit/xUnique/wiki">
            <span class="octicon octicon-book"></span> <span class="full-word">Wiki</span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>        </li>
    </ul>
    <div class="sunken-menu-separator"></div>
    <ul class="sunken-menu-group">

      <li class="tooltipped tooltipped-w" aria-label="Pulse">
        <a href="/truebit/xUnique/pulse/weekly" aria-label="Pulse" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="pulse /truebit/xUnique/pulse/weekly">
          <span class="octicon octicon-pulse"></span> <span class="full-word">Pulse</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

      <li class="tooltipped tooltipped-w" aria-label="Graphs">
        <a href="/truebit/xUnique/graphs" aria-label="Graphs" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="repo_graphs repo_contributors /truebit/xUnique/graphs">
          <span class="octicon octicon-graph"></span> <span class="full-word">Graphs</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>
    </ul>


  </div>
</div>

              <div class="only-with-full-nav">
                
  
<div class="clone-url "
  data-protocol-type="http"
  data-url="/users/set_protocol?protocol_selector=http&amp;protocol_type=clone">
  <h3><strong>HTTPS</strong> clone URL</h3>
  <div class="input-group">
    <input type="text" class="input-mini input-monospace js-url-field"
           value="https://github.com/truebit/xUnique.git" readonly="readonly">
    <span class="input-group-button">
      <button aria-label="Copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/truebit/xUnique.git" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>

  
<div class="clone-url open"
  data-protocol-type="ssh"
  data-url="/users/set_protocol?protocol_selector=ssh&amp;protocol_type=clone">
  <h3><strong>SSH</strong> clone URL</h3>
  <div class="input-group">
    <input type="text" class="input-mini input-monospace js-url-field"
           value="git@github.com:truebit/xUnique.git" readonly="readonly">
    <span class="input-group-button">
      <button aria-label="Copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="git@github.com:truebit/xUnique.git" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>

  
<div class="clone-url "
  data-protocol-type="subversion"
  data-url="/users/set_protocol?protocol_selector=subversion&amp;protocol_type=clone">
  <h3><strong>Subversion</strong> checkout URL</h3>
  <div class="input-group">
    <input type="text" class="input-mini input-monospace js-url-field"
           value="https://github.com/truebit/xUnique" readonly="readonly">
    <span class="input-group-button">
      <button aria-label="Copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/truebit/xUnique" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>


<p class="clone-options">You can clone with
      <a href="#" class="js-clone-selector" data-protocol="http">HTTPS</a>,
      <a href="#" class="js-clone-selector" data-protocol="ssh">SSH</a>,
      or <a href="#" class="js-clone-selector" data-protocol="subversion">Subversion</a>.
  <a href="https://help.github.com/articles/which-remote-url-should-i-use" class="help tooltipped tooltipped-n" aria-label="Get help on which URL is right for you.">
    <span class="octicon octicon-question"></span>
  </a>
</p>



                <a href="/truebit/xUnique/archive/master.zip"
                   class="minibutton sidebar-button"
                   aria-label="Download truebit/xUnique as a zip file"
                   title="Download truebit/xUnique as a zip file"
                   rel="nofollow">
                  <span class="octicon octicon-cloud-download"></span>
                  Download ZIP
                </a>
              </div>
        </div><!-- /.repository-sidebar -->

        <div id="js-repo-pjax-container" class="repository-content context-loader-container" data-pjax-container>
          

<a href="/truebit/xUnique/blob/12304631a8f3bf7e182312d06d56134195c79093/xUnique.py" class="hidden js-permalink-shortcut" data-hotkey="y">Permalink</a>

<!-- blob contrib key: blob_contributors:v21:38ad2503ae07b976d5afe770fa8597c1 -->

<div class="file-navigation">
  
<div class="select-menu js-menu-container js-select-menu" >
  <span class="minibutton select-menu-button js-menu-target css-truncate" data-hotkey="w"
    data-master-branch="master"
    data-ref="master"
    title="master"
    role="button" aria-label="Switch branches or tags" tabindex="0" aria-haspopup="true">
    <span class="octicon octicon-git-branch"></span>
    <i>branch:</i>
    <span class="js-select-button css-truncate-target">master</span>
  </span>

  <div class="select-menu-modal-holder js-menu-content js-navigation-container" data-pjax aria-hidden="true">

    <div class="select-menu-modal">
      <div class="select-menu-header">
        <span class="select-menu-title">Switch branches/tags</span>
        <span class="octicon octicon-x js-menu-close" role="button" aria-label="Close"></span>
      </div> <!-- /.select-menu-header -->

      <div class="select-menu-filters">
        <div class="select-menu-text-filter">
          <input type="text" aria-label="Filter branches/tags" id="context-commitish-filter-field" class="js-filterable-field js-navigation-enable" placeholder="Filter branches/tags">
        </div>
        <div class="select-menu-tabs">
          <ul>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="branches" class="js-select-menu-tab">Branches</a>
            </li>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="tags" class="js-select-menu-tab">Tags</a>
            </li>
          </ul>
        </div><!-- /.select-menu-tabs -->
      </div><!-- /.select-menu-filters -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="branches">

        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <div class="select-menu-item js-navigation-item selected">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/truebit/xUnique/blob/master/xUnique.py"
                 data-name="master"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="master">master</a>
            </div> <!-- /.select-menu-item -->
        </div>

          <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="tags">
        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/truebit/xUnique/tree/v3.0.0/xUnique.py"
                 data-name="v3.0.0"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="v3.0.0">v3.0.0</a>
            </div> <!-- /.select-menu-item -->
            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/truebit/xUnique/tree/v2.0.1/xUnique.py"
                 data-name="v2.0.1"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="v2.0.1">v2.0.1</a>
            </div> <!-- /.select-menu-item -->
            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/truebit/xUnique/tree/v2.0.0/xUnique.py"
                 data-name="v2.0.0"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="v2.0.0">v2.0.0</a>
            </div> <!-- /.select-menu-item -->
            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/truebit/xUnique/tree/v1.0.0/xUnique.py"
                 data-name="v1.0.0"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="v1.0.0">v1.0.0</a>
            </div> <!-- /.select-menu-item -->
        </div>

        <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

    </div> <!-- /.select-menu-modal -->
  </div> <!-- /.select-menu-modal-holder -->
</div> <!-- /.select-menu -->

  <div class="button-group right">
    <a href="/truebit/xUnique/find/master"
          class="js-show-file-finder minibutton empty-icon tooltipped tooltipped-s"
          data-pjax
          data-hotkey="t"
          aria-label="Quickly jump between files">
      <span class="octicon octicon-list-unordered"></span>
    </a>
    <button class="js-zeroclipboard minibutton zeroclipboard-button"
          data-clipboard-text="xUnique.py"
          aria-label="Copy to clipboard"
          data-copied-hint="Copied!">
      <span class="octicon octicon-clippy"></span>
    </button>
  </div>

  <div class="breadcrumb">
    <span class='repo-root js-repo-root'><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/truebit/xUnique" class="" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">xUnique</span></a></span></span><span class="separator"> / </span><strong class="final-path">xUnique.py</strong>
  </div>
</div>


  <div class="commit file-history-tease">
      <img alt="Sean Wang" class="main-avatar" data-user="754906" height="24" src="https://avatars0.githubusercontent.com/u/754906?v=2&amp;s=48" width="24" />
      <span class="author"><a href="/truebit" rel="author">truebit</a></span>
      <time datetime="2014-08-07T23:47:19+08:00" is="relative-time">August 07, 2014</time>
      <div class="commit-title">
          <a href="/truebit/xUnique/commit/12304631a8f3bf7e182312d06d56134195c79093" class="message" data-pjax="true" title="add more verbose output;make path name clear">add more verbose output;make path name clear</a>
      </div>

    <div class="participation">
      <p class="quickstat"><a href="#blob_contributors_box" rel="facebox"><strong>1</strong>  contributor</a></p>
      
    </div>
    <div id="blob_contributors_box" style="display:none">
      <h2 class="facebox-header">Users who have contributed to this file</h2>
      <ul class="facebox-user-list">
          <li class="facebox-user-list-item">
            <img alt="Sean Wang" data-user="754906" height="24" src="https://avatars0.githubusercontent.com/u/754906?v=2&amp;s=48" width="24" />
            <a href="/truebit">truebit</a>
          </li>
      </ul>
    </div>
  </div>

<div class="file-box">
  <div class="file">
    <div class="meta clearfix">
      <div class="info file-name">
          <span class="mode" title="File mode">executable file</span>
          <span class="meta-divider"></span>
          <span>426 lines (390 sloc)</span>
          <span class="meta-divider"></span>
        <span>19.825 kb</span>
      </div>
      <div class="actions">
        <div class="button-group">
          <a href="/truebit/xUnique/raw/master/xUnique.py" class="minibutton " id="raw-url">Raw</a>
            <a href="/truebit/xUnique/blame/master/xUnique.py" class="minibutton js-update-url-with-hash">Blame</a>
          <a href="/truebit/xUnique/commits/master/xUnique.py" class="minibutton " rel="nofollow">History</a>
        </div><!-- /.button-group -->


              <a class="octicon-button tooltipped tooltipped-n js-update-url-with-hash"
                 aria-label="Clicking this button will fork this project so you can edit the file"
                 href="/truebit/xUnique/edit/master/xUnique.py"
                 data-method="post" rel="nofollow"><span class="octicon octicon-pencil"></span></a>

            <a class="octicon-button danger tooltipped tooltipped-s"
               href="/truebit/xUnique/delete/master/xUnique.py"
               aria-label="Fork this project and delete file"
               data-method="post" data-test-id="delete-blob-file" rel="nofollow">
          <span class="octicon octicon-trashcan"></span>
        </a>
      </div><!-- /.actions -->
    </div>
      
  <div class="blob-wrapper data type-python">
      <table class="highlight tab-size-8 js-file-line-container">
      <tr>
        <td id="L1" class="blob-line-num js-line-number" data-line-number="1"></td>
        <td id="LC1" class="blob-line-code js-file-line"><span class="c">#!/usr/bin/env python</span></td>
      </tr>
      <tr>
        <td id="L2" class="blob-line-num js-line-number" data-line-number="2"></td>
        <td id="LC2" class="blob-line-code js-file-line"><span class="c"># -*- coding: utf-8 -*-</span></td>
      </tr>
      <tr>
        <td id="L3" class="blob-line-num js-line-number" data-line-number="3"></td>
        <td id="LC3" class="blob-line-code js-file-line"><span class="sd">&quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L4" class="blob-line-num js-line-number" data-line-number="4"></td>
        <td id="LC4" class="blob-line-code js-file-line"><span class="sd">This software is licensed under the Apache 2 license, quoted below.</span></td>
      </tr>
      <tr>
        <td id="L5" class="blob-line-num js-line-number" data-line-number="5"></td>
        <td id="LC5" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L6" class="blob-line-num js-line-number" data-line-number="6"></td>
        <td id="LC6" class="blob-line-code js-file-line"><span class="sd">Copyright 2014 Xiao Wang &lt;wangxiao8611@gmail.com, http://fclef.wordpress.com/about&gt;</span></td>
      </tr>
      <tr>
        <td id="L7" class="blob-line-num js-line-number" data-line-number="7"></td>
        <td id="LC7" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L8" class="blob-line-num js-line-number" data-line-number="8"></td>
        <td id="LC8" class="blob-line-code js-file-line"><span class="sd">Licensed under the Apache License, Version 2.0 (the &quot;License&quot;); you may not</span></td>
      </tr>
      <tr>
        <td id="L9" class="blob-line-num js-line-number" data-line-number="9"></td>
        <td id="LC9" class="blob-line-code js-file-line"><span class="sd">use this file except in compliance with the License. You may obtain a copy of</span></td>
      </tr>
      <tr>
        <td id="L10" class="blob-line-num js-line-number" data-line-number="10"></td>
        <td id="LC10" class="blob-line-code js-file-line"><span class="sd">the License at</span></td>
      </tr>
      <tr>
        <td id="L11" class="blob-line-num js-line-number" data-line-number="11"></td>
        <td id="LC11" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L12" class="blob-line-num js-line-number" data-line-number="12"></td>
        <td id="LC12" class="blob-line-code js-file-line"><span class="sd">    http://www.apache.org/licenses/LICENSE-2.0</span></td>
      </tr>
      <tr>
        <td id="L13" class="blob-line-num js-line-number" data-line-number="13"></td>
        <td id="LC13" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L14" class="blob-line-num js-line-number" data-line-number="14"></td>
        <td id="LC14" class="blob-line-code js-file-line"><span class="sd">Unless required by applicable law or agreed to in writing, software</span></td>
      </tr>
      <tr>
        <td id="L15" class="blob-line-num js-line-number" data-line-number="15"></td>
        <td id="LC15" class="blob-line-code js-file-line"><span class="sd">distributed under the License is distributed on an &quot;AS IS&quot; BASIS, WITHOUT</span></td>
      </tr>
      <tr>
        <td id="L16" class="blob-line-num js-line-number" data-line-number="16"></td>
        <td id="LC16" class="blob-line-code js-file-line"><span class="sd">WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the</span></td>
      </tr>
      <tr>
        <td id="L17" class="blob-line-num js-line-number" data-line-number="17"></td>
        <td id="LC17" class="blob-line-code js-file-line"><span class="sd">License for the specific language governing permissions and limitations under</span></td>
      </tr>
      <tr>
        <td id="L18" class="blob-line-num js-line-number" data-line-number="18"></td>
        <td id="LC18" class="blob-line-code js-file-line"><span class="sd">the License.</span></td>
      </tr>
      <tr>
        <td id="L19" class="blob-line-num js-line-number" data-line-number="19"></td>
        <td id="LC19" class="blob-line-code js-file-line"><span class="sd">&quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L20" class="blob-line-num js-line-number" data-line-number="20"></td>
        <td id="LC20" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L21" class="blob-line-num js-line-number" data-line-number="21"></td>
        <td id="LC21" class="blob-line-code js-file-line"><span class="kn">from</span> <span class="nn">__future__</span> <span class="kn">import</span> <span class="n">unicode_literals</span></td>
      </tr>
      <tr>
        <td id="L22" class="blob-line-num js-line-number" data-line-number="22"></td>
        <td id="LC22" class="blob-line-code js-file-line"><span class="kn">from</span> <span class="nn">__future__</span> <span class="kn">import</span> <span class="n">print_function</span></td>
      </tr>
      <tr>
        <td id="L23" class="blob-line-num js-line-number" data-line-number="23"></td>
        <td id="LC23" class="blob-line-code js-file-line"><span class="kn">from</span> <span class="nn">subprocess</span> <span class="kn">import</span> <span class="p">(</span><span class="n">check_output</span> <span class="k">as</span> <span class="n">sp_co</span><span class="p">,</span> <span class="n">check_call</span> <span class="k">as</span> <span class="n">sp_cc</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L24" class="blob-line-num js-line-number" data-line-number="24"></td>
        <td id="LC24" class="blob-line-code js-file-line"><span class="kn">from</span> <span class="nn">os</span> <span class="kn">import</span> <span class="n">path</span><span class="p">,</span> <span class="n">unlink</span><span class="p">,</span> <span class="n">rename</span></td>
      </tr>
      <tr>
        <td id="L25" class="blob-line-num js-line-number" data-line-number="25"></td>
        <td id="LC25" class="blob-line-code js-file-line"><span class="kn">from</span> <span class="nn">hashlib</span> <span class="kn">import</span> <span class="n">md5</span> <span class="k">as</span> <span class="n">hl_md5</span></td>
      </tr>
      <tr>
        <td id="L26" class="blob-line-num js-line-number" data-line-number="26"></td>
        <td id="LC26" class="blob-line-code js-file-line"><span class="kn">from</span> <span class="nn">json</span> <span class="kn">import</span> <span class="p">(</span><span class="n">loads</span> <span class="k">as</span> <span class="n">json_loads</span><span class="p">,</span> <span class="n">dump</span> <span class="k">as</span> <span class="n">json_dump</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L27" class="blob-line-num js-line-number" data-line-number="27"></td>
        <td id="LC27" class="blob-line-code js-file-line"><span class="kn">from</span> <span class="nn">urllib</span> <span class="kn">import</span> <span class="n">urlretrieve</span></td>
      </tr>
      <tr>
        <td id="L28" class="blob-line-num js-line-number" data-line-number="28"></td>
        <td id="LC28" class="blob-line-code js-file-line"><span class="kn">from</span> <span class="nn">fileinput</span> <span class="kn">import</span> <span class="p">(</span><span class="nb">input</span> <span class="k">as</span> <span class="n">fi_input</span><span class="p">,</span> <span class="n">close</span> <span class="k">as</span> <span class="n">fi_close</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L29" class="blob-line-num js-line-number" data-line-number="29"></td>
        <td id="LC29" class="blob-line-code js-file-line"><span class="kn">from</span> <span class="nn">re</span> <span class="kn">import</span> <span class="nb">compile</span> <span class="k">as</span> <span class="n">re_compile</span></td>
      </tr>
      <tr>
        <td id="L30" class="blob-line-num js-line-number" data-line-number="30"></td>
        <td id="LC30" class="blob-line-code js-file-line"><span class="kn">from</span> <span class="nn">sys</span> <span class="kn">import</span> <span class="p">(</span><span class="n">argv</span> <span class="k">as</span> <span class="n">sys_argv</span><span class="p">,</span> <span class="n">getfilesystemencoding</span> <span class="k">as</span> <span class="n">sys_get_fs_encoding</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L31" class="blob-line-num js-line-number" data-line-number="31"></td>
        <td id="LC31" class="blob-line-code js-file-line"><span class="kn">from</span> <span class="nn">collections</span> <span class="kn">import</span> <span class="n">deque</span></td>
      </tr>
      <tr>
        <td id="L32" class="blob-line-num js-line-number" data-line-number="32"></td>
        <td id="LC32" class="blob-line-code js-file-line"><span class="kn">from</span> <span class="nn">filecmp</span> <span class="kn">import</span> <span class="nb">cmp</span> <span class="k">as</span> <span class="n">filecmp_cmp</span></td>
      </tr>
      <tr>
        <td id="L33" class="blob-line-num js-line-number" data-line-number="33"></td>
        <td id="LC33" class="blob-line-code js-file-line"><span class="kn">from</span> <span class="nn">optparse</span> <span class="kn">import</span> <span class="n">OptionParser</span></td>
      </tr>
      <tr>
        <td id="L34" class="blob-line-num js-line-number" data-line-number="34"></td>
        <td id="LC34" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L35" class="blob-line-num js-line-number" data-line-number="35"></td>
        <td id="LC35" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L36" class="blob-line-num js-line-number" data-line-number="36"></td>
        <td id="LC36" class="blob-line-code js-file-line"><span class="n">md5_hex</span> <span class="o">=</span> <span class="k">lambda</span> <span class="n">a_str</span><span class="p">:</span> <span class="n">hl_md5</span><span class="p">(</span><span class="n">a_str</span><span class="o">.</span><span class="n">encode</span><span class="p">(</span><span class="s">&#39;utf-8&#39;</span><span class="p">))</span><span class="o">.</span><span class="n">hexdigest</span><span class="p">()</span><span class="o">.</span><span class="n">upper</span><span class="p">()</span></td>
      </tr>
      <tr>
        <td id="L37" class="blob-line-num js-line-number" data-line-number="37"></td>
        <td id="LC37" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L38" class="blob-line-num js-line-number" data-line-number="38"></td>
        <td id="LC38" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L39" class="blob-line-num js-line-number" data-line-number="39"></td>
        <td id="LC39" class="blob-line-code js-file-line"><span class="k">class</span> <span class="nc">XUnique</span><span class="p">(</span><span class="nb">object</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L40" class="blob-line-num js-line-number" data-line-number="40"></td>
        <td id="LC40" class="blob-line-code js-file-line">    <span class="k">def</span> <span class="nf">__init__</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">target_path</span><span class="p">,</span> <span class="n">verbose</span><span class="o">=</span><span class="bp">False</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L41" class="blob-line-num js-line-number" data-line-number="41"></td>
        <td id="LC41" class="blob-line-code js-file-line">        <span class="c"># check project path</span></td>
      </tr>
      <tr>
        <td id="L42" class="blob-line-num js-line-number" data-line-number="42"></td>
        <td id="LC42" class="blob-line-code js-file-line">        <span class="n">abs_target_path</span> <span class="o">=</span> <span class="n">path</span><span class="o">.</span><span class="n">abspath</span><span class="p">(</span><span class="n">target_path</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L43" class="blob-line-num js-line-number" data-line-number="43"></td>
        <td id="LC43" class="blob-line-code js-file-line">        <span class="k">if</span> <span class="ow">not</span> <span class="n">path</span><span class="o">.</span><span class="n">exists</span><span class="p">(</span><span class="n">abs_target_path</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L44" class="blob-line-num js-line-number" data-line-number="44"></td>
        <td id="LC44" class="blob-line-code js-file-line">            <span class="k">raise</span> <span class="ne">SystemExit</span><span class="p">(</span><span class="s">&#39;Path &quot;{!r}&quot; does not exist!&#39;</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="n">abs_target_path</span><span class="p">))</span></td>
      </tr>
      <tr>
        <td id="L45" class="blob-line-num js-line-number" data-line-number="45"></td>
        <td id="LC45" class="blob-line-code js-file-line">        <span class="k">elif</span> <span class="n">abs_target_path</span><span class="o">.</span><span class="n">endswith</span><span class="p">(</span><span class="s">&#39;xcodeproj&#39;</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L46" class="blob-line-num js-line-number" data-line-number="46"></td>
        <td id="LC46" class="blob-line-code js-file-line">            <span class="bp">self</span><span class="o">.</span><span class="n">xcodeproj_path</span> <span class="o">=</span> <span class="n">abs_target_path</span></td>
      </tr>
      <tr>
        <td id="L47" class="blob-line-num js-line-number" data-line-number="47"></td>
        <td id="LC47" class="blob-line-code js-file-line">            <span class="bp">self</span><span class="o">.</span><span class="n">xcode_pbxproj_path</span> <span class="o">=</span> <span class="n">path</span><span class="o">.</span><span class="n">join</span><span class="p">(</span><span class="n">abs_target_path</span><span class="p">,</span> <span class="s">&#39;project.pbxproj&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L48" class="blob-line-num js-line-number" data-line-number="48"></td>
        <td id="LC48" class="blob-line-code js-file-line">        <span class="k">elif</span> <span class="n">abs_target_path</span><span class="o">.</span><span class="n">endswith</span><span class="p">(</span><span class="s">&#39;project.pbxproj&#39;</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L49" class="blob-line-num js-line-number" data-line-number="49"></td>
        <td id="LC49" class="blob-line-code js-file-line">            <span class="bp">self</span><span class="o">.</span><span class="n">xcode_pbxproj_path</span> <span class="o">=</span> <span class="n">abs_target_path</span></td>
      </tr>
      <tr>
        <td id="L50" class="blob-line-num js-line-number" data-line-number="50"></td>
        <td id="LC50" class="blob-line-code js-file-line">            <span class="bp">self</span><span class="o">.</span><span class="n">xcodeproj_path</span> <span class="o">=</span> <span class="n">path</span><span class="o">.</span><span class="n">split</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="n">xcode_pbxproj_path</span><span class="p">)[</span><span class="mi">0</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L51" class="blob-line-num js-line-number" data-line-number="51"></td>
        <td id="LC51" class="blob-line-code js-file-line">        <span class="k">else</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L52" class="blob-line-num js-line-number" data-line-number="52"></td>
        <td id="LC52" class="blob-line-code js-file-line">            <span class="k">raise</span> <span class="ne">SystemExit</span><span class="p">(</span><span class="s">&quot;Path must be dir &#39;.xcodeproj&#39; or file &#39;project.pbxproj&#39;&quot;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L53" class="blob-line-num js-line-number" data-line-number="53"></td>
        <td id="LC53" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">verbose</span> <span class="o">=</span> <span class="n">verbose</span></td>
      </tr>
      <tr>
        <td id="L54" class="blob-line-num js-line-number" data-line-number="54"></td>
        <td id="LC54" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">vprint</span> <span class="o">=</span> <span class="k">print</span> <span class="k">if</span> <span class="bp">self</span><span class="o">.</span><span class="n">verbose</span> <span class="k">else</span> <span class="k">lambda</span> <span class="o">*</span><span class="n">a</span><span class="p">,</span> <span class="o">**</span><span class="n">k</span><span class="p">:</span> <span class="bp">None</span></td>
      </tr>
      <tr>
        <td id="L55" class="blob-line-num js-line-number" data-line-number="55"></td>
        <td id="LC55" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">proj_root</span> <span class="o">=</span> <span class="n">path</span><span class="o">.</span><span class="n">basename</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="n">xcodeproj_path</span><span class="p">)</span>  <span class="c"># example MyProject.xpbproj</span></td>
      </tr>
      <tr>
        <td id="L56" class="blob-line-num js-line-number" data-line-number="56"></td>
        <td id="LC56" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">proj_json</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">pbxproj_to_json</span><span class="p">()</span></td>
      </tr>
      <tr>
        <td id="L57" class="blob-line-num js-line-number" data-line-number="57"></td>
        <td id="LC57" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">nodes</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">proj_json</span><span class="p">[</span><span class="s">&#39;objects&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L58" class="blob-line-num js-line-number" data-line-number="58"></td>
        <td id="LC58" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">root_hex</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">proj_json</span><span class="p">[</span><span class="s">&#39;rootObject&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L59" class="blob-line-num js-line-number" data-line-number="59"></td>
        <td id="LC59" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">root_node</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">nodes</span><span class="p">[</span><span class="bp">self</span><span class="o">.</span><span class="n">root_hex</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L60" class="blob-line-num js-line-number" data-line-number="60"></td>
        <td id="LC60" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">main_group_hex</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">root_node</span><span class="p">[</span><span class="s">&#39;mainGroup&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L61" class="blob-line-num js-line-number" data-line-number="61"></td>
        <td id="LC61" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">__result</span> <span class="o">=</span> <span class="p">{}</span></td>
      </tr>
      <tr>
        <td id="L62" class="blob-line-num js-line-number" data-line-number="62"></td>
        <td id="LC62" class="blob-line-code js-file-line">        <span class="c"># initialize root content</span></td>
      </tr>
      <tr>
        <td id="L63" class="blob-line-num js-line-number" data-line-number="63"></td>
        <td id="LC63" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">__result</span><span class="o">.</span><span class="n">update</span><span class="p">(</span></td>
      </tr>
      <tr>
        <td id="L64" class="blob-line-num js-line-number" data-line-number="64"></td>
        <td id="LC64" class="blob-line-code js-file-line">            <span class="p">{</span></td>
      </tr>
      <tr>
        <td id="L65" class="blob-line-num js-line-number" data-line-number="65"></td>
        <td id="LC65" class="blob-line-code js-file-line">                <span class="bp">self</span><span class="o">.</span><span class="n">root_hex</span><span class="p">:</span> <span class="p">{</span><span class="s">&#39;path&#39;</span><span class="p">:</span> <span class="bp">self</span><span class="o">.</span><span class="n">proj_root</span><span class="p">,</span></td>
      </tr>
      <tr>
        <td id="L66" class="blob-line-num js-line-number" data-line-number="66"></td>
        <td id="LC66" class="blob-line-code js-file-line">                                <span class="s">&#39;new_key&#39;</span><span class="p">:</span> <span class="n">md5_hex</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="n">proj_root</span><span class="p">),</span></td>
      </tr>
      <tr>
        <td id="L67" class="blob-line-num js-line-number" data-line-number="67"></td>
        <td id="LC67" class="blob-line-code js-file-line">                                <span class="s">&#39;type&#39;</span><span class="p">:</span> <span class="bp">self</span><span class="o">.</span><span class="n">root_node</span><span class="p">[</span><span class="s">&#39;isa&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L68" class="blob-line-num js-line-number" data-line-number="68"></td>
        <td id="LC68" class="blob-line-code js-file-line">                <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L69" class="blob-line-num js-line-number" data-line-number="69"></td>
        <td id="LC69" class="blob-line-code js-file-line">            <span class="p">})</span></td>
      </tr>
      <tr>
        <td id="L70" class="blob-line-num js-line-number" data-line-number="70"></td>
        <td id="LC70" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L71" class="blob-line-num js-line-number" data-line-number="71"></td>
        <td id="LC71" class="blob-line-code js-file-line">    <span class="k">def</span> <span class="nf">pbxproj_to_json</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L72" class="blob-line-num js-line-number" data-line-number="72"></td>
        <td id="LC72" class="blob-line-code js-file-line">        <span class="n">pbproj_to_json_cmd</span> <span class="o">=</span> <span class="p">[</span><span class="s">&#39;plutil&#39;</span><span class="p">,</span> <span class="s">&#39;-convert&#39;</span><span class="p">,</span> <span class="s">&#39;json&#39;</span><span class="p">,</span> <span class="s">&#39;-o&#39;</span><span class="p">,</span> <span class="s">&#39;-&#39;</span><span class="p">,</span> <span class="bp">self</span><span class="o">.</span><span class="n">xcode_pbxproj_path</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L73" class="blob-line-num js-line-number" data-line-number="73"></td>
        <td id="LC73" class="blob-line-code js-file-line">        <span class="n">json_unicode_str</span> <span class="o">=</span> <span class="n">sp_co</span><span class="p">(</span><span class="n">pbproj_to_json_cmd</span><span class="p">)</span><span class="o">.</span><span class="n">decode</span><span class="p">(</span><span class="n">sys_get_fs_encoding</span><span class="p">())</span></td>
      </tr>
      <tr>
        <td id="L74" class="blob-line-num js-line-number" data-line-number="74"></td>
        <td id="LC74" class="blob-line-code js-file-line">        <span class="k">return</span> <span class="n">json_loads</span><span class="p">(</span><span class="n">json_unicode_str</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L75" class="blob-line-num js-line-number" data-line-number="75"></td>
        <td id="LC75" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L76" class="blob-line-num js-line-number" data-line-number="76"></td>
        <td id="LC76" class="blob-line-code js-file-line">    <span class="k">def</span> <span class="nf">__set_to_result</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">parent_hex</span><span class="p">,</span> <span class="n">current_hex</span><span class="p">,</span> <span class="n">current_path_key</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L77" class="blob-line-num js-line-number" data-line-number="77"></td>
        <td id="LC77" class="blob-line-code js-file-line">        <span class="n">current_node</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">nodes</span><span class="p">[</span><span class="n">current_hex</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L78" class="blob-line-num js-line-number" data-line-number="78"></td>
        <td id="LC78" class="blob-line-code js-file-line">        <span class="k">if</span> <span class="nb">isinstance</span><span class="p">(</span><span class="n">current_path_key</span><span class="p">,</span> <span class="p">(</span><span class="nb">list</span><span class="p">,</span> <span class="nb">tuple</span><span class="p">)):</span></td>
      </tr>
      <tr>
        <td id="L79" class="blob-line-num js-line-number" data-line-number="79"></td>
        <td id="LC79" class="blob-line-code js-file-line">            <span class="n">current_path</span> <span class="o">=</span> <span class="s">&#39;/&#39;</span><span class="o">.</span><span class="n">join</span><span class="p">([</span><span class="n">current_node</span><span class="p">[</span><span class="n">i</span><span class="p">]</span> <span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="n">current_path_key</span><span class="p">])</span></td>
      </tr>
      <tr>
        <td id="L80" class="blob-line-num js-line-number" data-line-number="80"></td>
        <td id="LC80" class="blob-line-code js-file-line">        <span class="k">elif</span> <span class="nb">isinstance</span><span class="p">(</span><span class="n">current_path_key</span><span class="p">,</span> <span class="p">(</span><span class="nb">basestring</span><span class="p">,</span> <span class="nb">unicode</span><span class="p">)):</span></td>
      </tr>
      <tr>
        <td id="L81" class="blob-line-num js-line-number" data-line-number="81"></td>
        <td id="LC81" class="blob-line-code js-file-line">            <span class="k">if</span> <span class="n">current_path_key</span> <span class="ow">in</span> <span class="n">current_node</span><span class="o">.</span><span class="n">keys</span><span class="p">():</span></td>
      </tr>
      <tr>
        <td id="L82" class="blob-line-num js-line-number" data-line-number="82"></td>
        <td id="LC82" class="blob-line-code js-file-line">                <span class="n">current_path</span> <span class="o">=</span> <span class="n">current_node</span><span class="p">[</span><span class="n">current_path_key</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L83" class="blob-line-num js-line-number" data-line-number="83"></td>
        <td id="LC83" class="blob-line-code js-file-line">            <span class="k">else</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L84" class="blob-line-num js-line-number" data-line-number="84"></td>
        <td id="LC84" class="blob-line-code js-file-line">                <span class="n">current_path</span> <span class="o">=</span> <span class="n">current_path_key</span></td>
      </tr>
      <tr>
        <td id="L85" class="blob-line-num js-line-number" data-line-number="85"></td>
        <td id="LC85" class="blob-line-code js-file-line">        <span class="k">else</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L86" class="blob-line-num js-line-number" data-line-number="86"></td>
        <td id="LC86" class="blob-line-code js-file-line">            <span class="k">raise</span> <span class="ne">KeyError</span><span class="p">(</span><span class="s">&#39;current_path_key must be list/tuple/string&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L87" class="blob-line-num js-line-number" data-line-number="87"></td>
        <td id="LC87" class="blob-line-code js-file-line">        <span class="n">cur_abs_path</span> <span class="o">=</span> <span class="s">&#39;{}/{}&#39;</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="n">__result</span><span class="p">[</span><span class="n">parent_hex</span><span class="p">][</span><span class="s">&#39;path&#39;</span><span class="p">],</span> <span class="n">current_path</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L88" class="blob-line-num js-line-number" data-line-number="88"></td>
        <td id="LC88" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">__result</span><span class="o">.</span><span class="n">update</span><span class="p">({</span></td>
      </tr>
      <tr>
        <td id="L89" class="blob-line-num js-line-number" data-line-number="89"></td>
        <td id="LC89" class="blob-line-code js-file-line">            <span class="n">current_hex</span><span class="p">:</span> <span class="p">{</span><span class="s">&#39;path&#39;</span><span class="p">:</span> <span class="n">cur_abs_path</span><span class="p">,</span></td>
      </tr>
      <tr>
        <td id="L90" class="blob-line-num js-line-number" data-line-number="90"></td>
        <td id="LC90" class="blob-line-code js-file-line">                          <span class="s">&#39;new_key&#39;</span><span class="p">:</span> <span class="n">md5_hex</span><span class="p">(</span><span class="n">cur_abs_path</span><span class="p">),</span></td>
      </tr>
      <tr>
        <td id="L91" class="blob-line-num js-line-number" data-line-number="91"></td>
        <td id="LC91" class="blob-line-code js-file-line">                          <span class="s">&#39;type&#39;</span><span class="p">:</span> <span class="bp">self</span><span class="o">.</span><span class="n">nodes</span><span class="p">[</span><span class="n">current_hex</span><span class="p">][</span><span class="s">&#39;isa&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L92" class="blob-line-num js-line-number" data-line-number="92"></td>
        <td id="LC92" class="blob-line-code js-file-line">            <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L93" class="blob-line-num js-line-number" data-line-number="93"></td>
        <td id="LC93" class="blob-line-code js-file-line">        <span class="p">})</span></td>
      </tr>
      <tr>
        <td id="L94" class="blob-line-num js-line-number" data-line-number="94"></td>
        <td id="LC94" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L95" class="blob-line-num js-line-number" data-line-number="95"></td>
        <td id="LC95" class="blob-line-code js-file-line">    <span class="k">def</span> <span class="nf">unique_pbxproj</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L96" class="blob-line-num js-line-number" data-line-number="96"></td>
        <td id="LC96" class="blob-line-code js-file-line">        <span class="sd">&quot;&quot;&quot;&quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L97" class="blob-line-num js-line-number" data-line-number="97"></td>
        <td id="LC97" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">unique_project</span><span class="p">()</span></td>
      </tr>
      <tr>
        <td id="L98" class="blob-line-num js-line-number" data-line-number="98"></td>
        <td id="LC98" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">sort_pbxproj</span><span class="p">()</span></td>
      </tr>
      <tr>
        <td id="L99" class="blob-line-num js-line-number" data-line-number="99"></td>
        <td id="LC99" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L100" class="blob-line-num js-line-number" data-line-number="100"></td>
        <td id="LC100" class="blob-line-code js-file-line">    <span class="k">def</span> <span class="nf">unique_project</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L101" class="blob-line-num js-line-number" data-line-number="101"></td>
        <td id="LC101" class="blob-line-code js-file-line">        <span class="sd">&quot;&quot;&quot;iterate all nodes in pbxproj file:</span></td>
      </tr>
      <tr>
        <td id="L102" class="blob-line-num js-line-number" data-line-number="102"></td>
        <td id="LC102" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L103" class="blob-line-num js-line-number" data-line-number="103"></td>
        <td id="LC103" class="blob-line-code js-file-line"><span class="sd">        PBXProject</span></td>
      </tr>
      <tr>
        <td id="L104" class="blob-line-num js-line-number" data-line-number="104"></td>
        <td id="LC104" class="blob-line-code js-file-line"><span class="sd">        XCConfigurationList</span></td>
      </tr>
      <tr>
        <td id="L105" class="blob-line-num js-line-number" data-line-number="105"></td>
        <td id="LC105" class="blob-line-code js-file-line"><span class="sd">        PBXNativeTarget</span></td>
      </tr>
      <tr>
        <td id="L106" class="blob-line-num js-line-number" data-line-number="106"></td>
        <td id="LC106" class="blob-line-code js-file-line"><span class="sd">        PBXTargetDependency</span></td>
      </tr>
      <tr>
        <td id="L107" class="blob-line-num js-line-number" data-line-number="107"></td>
        <td id="LC107" class="blob-line-code js-file-line"><span class="sd">        PBXContainerItemProxy</span></td>
      </tr>
      <tr>
        <td id="L108" class="blob-line-num js-line-number" data-line-number="108"></td>
        <td id="LC108" class="blob-line-code js-file-line"><span class="sd">        XCBuildConfiguration</span></td>
      </tr>
      <tr>
        <td id="L109" class="blob-line-num js-line-number" data-line-number="109"></td>
        <td id="LC109" class="blob-line-code js-file-line"><span class="sd">        PBXSourcesBuildPhase</span></td>
      </tr>
      <tr>
        <td id="L110" class="blob-line-num js-line-number" data-line-number="110"></td>
        <td id="LC110" class="blob-line-code js-file-line"><span class="sd">        PBXFrameworksBuildPhase</span></td>
      </tr>
      <tr>
        <td id="L111" class="blob-line-num js-line-number" data-line-number="111"></td>
        <td id="LC111" class="blob-line-code js-file-line"><span class="sd">        PBXResourcesBuildPhase</span></td>
      </tr>
      <tr>
        <td id="L112" class="blob-line-num js-line-number" data-line-number="112"></td>
        <td id="LC112" class="blob-line-code js-file-line"><span class="sd">        PBXBuildFile</span></td>
      </tr>
      <tr>
        <td id="L113" class="blob-line-num js-line-number" data-line-number="113"></td>
        <td id="LC113" class="blob-line-code js-file-line"><span class="sd">        PBXReferenceProxy</span></td>
      </tr>
      <tr>
        <td id="L114" class="blob-line-num js-line-number" data-line-number="114"></td>
        <td id="LC114" class="blob-line-code js-file-line"><span class="sd">        PBXFileReference</span></td>
      </tr>
      <tr>
        <td id="L115" class="blob-line-num js-line-number" data-line-number="115"></td>
        <td id="LC115" class="blob-line-code js-file-line"><span class="sd">        PBXGroup</span></td>
      </tr>
      <tr>
        <td id="L116" class="blob-line-num js-line-number" data-line-number="116"></td>
        <td id="LC116" class="blob-line-code js-file-line"><span class="sd">        PBXVariantGroup</span></td>
      </tr>
      <tr>
        <td id="L117" class="blob-line-num js-line-number" data-line-number="117"></td>
        <td id="LC117" class="blob-line-code js-file-line"><span class="sd">        &quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L118" class="blob-line-num js-line-number" data-line-number="118"></td>
        <td id="LC118" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">__unique_project</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="n">root_hex</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L119" class="blob-line-num js-line-number" data-line-number="119"></td>
        <td id="LC119" class="blob-line-code js-file-line">        <span class="k">if</span> <span class="bp">self</span><span class="o">.</span><span class="n">verbose</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L120" class="blob-line-num js-line-number" data-line-number="120"></td>
        <td id="LC120" class="blob-line-code js-file-line">            <span class="n">debug_result_file_path</span> <span class="o">=</span> <span class="n">path</span><span class="o">.</span><span class="n">join</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="n">xcodeproj_path</span><span class="p">,</span> <span class="s">&#39;debug_result.json&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L121" class="blob-line-num js-line-number" data-line-number="121"></td>
        <td id="LC121" class="blob-line-code js-file-line">            <span class="k">with</span> <span class="nb">open</span><span class="p">(</span><span class="n">debug_result_file_path</span><span class="p">,</span> <span class="s">&#39;w&#39;</span><span class="p">)</span> <span class="k">as</span> <span class="n">debug_result_file</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L122" class="blob-line-num js-line-number" data-line-number="122"></td>
        <td id="LC122" class="blob-line-code js-file-line">                <span class="n">json_dump</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="n">__result</span><span class="p">,</span> <span class="n">debug_result_file</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L123" class="blob-line-num js-line-number" data-line-number="123"></td>
        <td id="LC123" class="blob-line-code js-file-line">            <span class="bp">self</span><span class="o">.</span><span class="n">vprint</span><span class="p">(</span><span class="s">&quot;result json file has been written to &#39;{}&#39;&quot;</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="n">debug_result_file_path</span><span class="p">))</span></td>
      </tr>
      <tr>
        <td id="L124" class="blob-line-num js-line-number" data-line-number="124"></td>
        <td id="LC124" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">replace_uuids_with_file</span><span class="p">()</span></td>
      </tr>
      <tr>
        <td id="L125" class="blob-line-num js-line-number" data-line-number="125"></td>
        <td id="LC125" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L126" class="blob-line-num js-line-number" data-line-number="126"></td>
        <td id="LC126" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L127" class="blob-line-num js-line-number" data-line-number="127"></td>
        <td id="LC127" class="blob-line-code js-file-line">    <span class="k">def</span> <span class="nf">replace_uuids_with_file</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L128" class="blob-line-num js-line-number" data-line-number="128"></td>
        <td id="LC128" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">vprint</span><span class="p">(</span><span class="s">&#39;replace UUIDs and remove unused UUIDs&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L129" class="blob-line-num js-line-number" data-line-number="129"></td>
        <td id="LC129" class="blob-line-code js-file-line">        <span class="n">uuid_ptn</span> <span class="o">=</span> <span class="n">re_compile</span><span class="p">(</span><span class="s">&#39;(?&lt;=\s)[0-9A-F]{24}(?=[\s;])&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L130" class="blob-line-num js-line-number" data-line-number="130"></td>
        <td id="LC130" class="blob-line-code js-file-line">        <span class="k">for</span> <span class="n">line</span> <span class="ow">in</span> <span class="n">fi_input</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="n">xcode_pbxproj_path</span><span class="p">,</span> <span class="n">backup</span><span class="o">=</span><span class="s">&#39;.bak&#39;</span><span class="p">,</span> <span class="n">inplace</span><span class="o">=</span><span class="mi">1</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L131" class="blob-line-num js-line-number" data-line-number="131"></td>
        <td id="LC131" class="blob-line-code js-file-line">            <span class="c"># project.pbxproj is an utf-8 encoded file</span></td>
      </tr>
      <tr>
        <td id="L132" class="blob-line-num js-line-number" data-line-number="132"></td>
        <td id="LC132" class="blob-line-code js-file-line">            <span class="n">line</span> <span class="o">=</span> <span class="n">line</span><span class="o">.</span><span class="n">decode</span><span class="p">(</span><span class="s">&#39;utf-8&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L133" class="blob-line-num js-line-number" data-line-number="133"></td>
        <td id="LC133" class="blob-line-code js-file-line">            <span class="n">uuid_list</span> <span class="o">=</span> <span class="n">uuid_ptn</span><span class="o">.</span><span class="n">findall</span><span class="p">(</span><span class="n">line</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L134" class="blob-line-num js-line-number" data-line-number="134"></td>
        <td id="LC134" class="blob-line-code js-file-line">            <span class="k">if</span> <span class="ow">not</span> <span class="n">uuid_list</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L135" class="blob-line-num js-line-number" data-line-number="135"></td>
        <td id="LC135" class="blob-line-code js-file-line">                <span class="k">print</span><span class="p">(</span><span class="n">line</span><span class="o">.</span><span class="n">encode</span><span class="p">(</span><span class="s">&#39;utf-8&#39;</span><span class="p">),</span> <span class="n">end</span><span class="o">=</span><span class="s">&#39;&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L136" class="blob-line-num js-line-number" data-line-number="136"></td>
        <td id="LC136" class="blob-line-code js-file-line">            <span class="k">else</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L137" class="blob-line-num js-line-number" data-line-number="137"></td>
        <td id="LC137" class="blob-line-code js-file-line">                <span class="n">new_line</span> <span class="o">=</span> <span class="n">line</span></td>
      </tr>
      <tr>
        <td id="L138" class="blob-line-num js-line-number" data-line-number="138"></td>
        <td id="LC138" class="blob-line-code js-file-line">                <span class="c"># remove line with non-existing element</span></td>
      </tr>
      <tr>
        <td id="L139" class="blob-line-num js-line-number" data-line-number="139"></td>
        <td id="LC139" class="blob-line-code js-file-line">                <span class="k">if</span> <span class="bp">self</span><span class="o">.</span><span class="n">__result</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="s">&#39;to_be_removed&#39;</span><span class="p">)</span> <span class="ow">and</span> <span class="nb">any</span><span class="p">(</span></td>
      </tr>
      <tr>
        <td id="L140" class="blob-line-num js-line-number" data-line-number="140"></td>
        <td id="LC140" class="blob-line-code js-file-line">                        <span class="n">i</span> <span class="k">for</span> <span class="n">i</span> <span class="ow">in</span> <span class="n">uuid_list</span> <span class="k">if</span> <span class="n">i</span> <span class="ow">in</span> <span class="bp">self</span><span class="o">.</span><span class="n">__result</span><span class="p">[</span><span class="s">&#39;to_be_removed&#39;</span><span class="p">]):</span></td>
      </tr>
      <tr>
        <td id="L141" class="blob-line-num js-line-number" data-line-number="141"></td>
        <td id="LC141" class="blob-line-code js-file-line">                    <span class="k">continue</span></td>
      </tr>
      <tr>
        <td id="L142" class="blob-line-num js-line-number" data-line-number="142"></td>
        <td id="LC142" class="blob-line-code js-file-line">                <span class="k">else</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L143" class="blob-line-num js-line-number" data-line-number="143"></td>
        <td id="LC143" class="blob-line-code js-file-line">                    <span class="k">for</span> <span class="n">uuid</span> <span class="ow">in</span> <span class="n">uuid_list</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L144" class="blob-line-num js-line-number" data-line-number="144"></td>
        <td id="LC144" class="blob-line-code js-file-line">                        <span class="n">new_line</span> <span class="o">=</span> <span class="n">new_line</span><span class="o">.</span><span class="n">replace</span><span class="p">(</span><span class="n">uuid</span><span class="p">,</span> <span class="bp">self</span><span class="o">.</span><span class="n">__result</span><span class="p">[</span><span class="n">uuid</span><span class="p">][</span><span class="s">&#39;new_key&#39;</span><span class="p">])</span></td>
      </tr>
      <tr>
        <td id="L145" class="blob-line-num js-line-number" data-line-number="145"></td>
        <td id="LC145" class="blob-line-code js-file-line">                    <span class="k">print</span><span class="p">(</span><span class="n">new_line</span><span class="o">.</span><span class="n">encode</span><span class="p">(</span><span class="s">&#39;utf-8&#39;</span><span class="p">),</span> <span class="n">end</span><span class="o">=</span><span class="s">&#39;&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L146" class="blob-line-num js-line-number" data-line-number="146"></td>
        <td id="LC146" class="blob-line-code js-file-line">        <span class="n">fi_close</span><span class="p">()</span></td>
      </tr>
      <tr>
        <td id="L147" class="blob-line-num js-line-number" data-line-number="147"></td>
        <td id="LC147" class="blob-line-code js-file-line">        <span class="n">tmp_path</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">xcode_pbxproj_path</span> <span class="o">+</span> <span class="s">&#39;.bak&#39;</span></td>
      </tr>
      <tr>
        <td id="L148" class="blob-line-num js-line-number" data-line-number="148"></td>
        <td id="LC148" class="blob-line-code js-file-line">        <span class="k">if</span> <span class="n">filecmp_cmp</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="n">xcode_pbxproj_path</span><span class="p">,</span> <span class="n">tmp_path</span><span class="p">,</span> <span class="n">shallow</span><span class="o">=</span><span class="bp">False</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L149" class="blob-line-num js-line-number" data-line-number="149"></td>
        <td id="LC149" class="blob-line-code js-file-line">            <span class="n">unlink</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="n">xcode_pbxproj_path</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L150" class="blob-line-num js-line-number" data-line-number="150"></td>
        <td id="LC150" class="blob-line-code js-file-line">            <span class="n">rename</span><span class="p">(</span><span class="n">tmp_path</span><span class="p">,</span> <span class="bp">self</span><span class="o">.</span><span class="n">xcode_pbxproj_path</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L151" class="blob-line-num js-line-number" data-line-number="151"></td>
        <td id="LC151" class="blob-line-code js-file-line">            <span class="k">print</span><span class="p">(</span><span class="s">&#39;Ignore uniquify, no changes made to&#39;</span><span class="p">,</span> <span class="bp">self</span><span class="o">.</span><span class="n">xcode_pbxproj_path</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L152" class="blob-line-num js-line-number" data-line-number="152"></td>
        <td id="LC152" class="blob-line-code js-file-line">        <span class="k">else</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L153" class="blob-line-num js-line-number" data-line-number="153"></td>
        <td id="LC153" class="blob-line-code js-file-line">            <span class="n">unlink</span><span class="p">(</span><span class="n">tmp_path</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L154" class="blob-line-num js-line-number" data-line-number="154"></td>
        <td id="LC154" class="blob-line-code js-file-line">            <span class="k">print</span><span class="p">(</span><span class="s">&#39;Uniquify done&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L155" class="blob-line-num js-line-number" data-line-number="155"></td>
        <td id="LC155" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L156" class="blob-line-num js-line-number" data-line-number="156"></td>
        <td id="LC156" class="blob-line-code js-file-line">    <span class="k">def</span> <span class="nf">sort_pbxproj_pl</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L157" class="blob-line-num js-line-number" data-line-number="157"></td>
        <td id="LC157" class="blob-line-code js-file-line">        <span class="sd">&quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L158" class="blob-line-num js-line-number" data-line-number="158"></td>
        <td id="LC158" class="blob-line-code js-file-line"><span class="sd">        deprecated, use pure python method sort_pbxproj() below</span></td>
      </tr>
      <tr>
        <td id="L159" class="blob-line-num js-line-number" data-line-number="159"></td>
        <td id="LC159" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L160" class="blob-line-num js-line-number" data-line-number="160"></td>
        <td id="LC160" class="blob-line-code js-file-line"><span class="sd">        https://github.com/truebit/webkit/commits/master/Tools/Scripts/sort-Xcode-project-file</span></td>
      </tr>
      <tr>
        <td id="L161" class="blob-line-num js-line-number" data-line-number="161"></td>
        <td id="LC161" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L162" class="blob-line-num js-line-number" data-line-number="162"></td>
        <td id="LC162" class="blob-line-code js-file-line"><span class="sd">        my modified version which supports:</span></td>
      </tr>
      <tr>
        <td id="L163" class="blob-line-num js-line-number" data-line-number="163"></td>
        <td id="LC163" class="blob-line-code js-file-line"><span class="sd">        1. sort PBXFileReference and PBXBuildFile sections</span></td>
      </tr>
      <tr>
        <td id="L164" class="blob-line-num js-line-number" data-line-number="164"></td>
        <td id="LC164" class="blob-line-code js-file-line"><span class="sd">        2. avoid creating new file if no changes made</span></td>
      </tr>
      <tr>
        <td id="L165" class="blob-line-num js-line-number" data-line-number="165"></td>
        <td id="LC165" class="blob-line-code js-file-line"><span class="sd">        &quot;&quot;&quot;</span></td>
      </tr>
      <tr>
        <td id="L166" class="blob-line-num js-line-number" data-line-number="166"></td>
        <td id="LC166" class="blob-line-code js-file-line">        <span class="n">sort_script_path</span> <span class="o">=</span> <span class="n">path</span><span class="o">.</span><span class="n">join</span><span class="p">(</span><span class="n">path</span><span class="o">.</span><span class="n">dirname</span><span class="p">(</span><span class="n">path</span><span class="o">.</span><span class="n">abspath</span><span class="p">(</span><span class="n">__file__</span><span class="p">)),</span> <span class="s">&#39;sort-Xcode-project-file-mod2.pl&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L167" class="blob-line-num js-line-number" data-line-number="167"></td>
        <td id="LC167" class="blob-line-code js-file-line">        <span class="k">if</span> <span class="ow">not</span> <span class="n">path</span><span class="o">.</span><span class="n">exists</span><span class="p">(</span><span class="n">sort_script_path</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L168" class="blob-line-num js-line-number" data-line-number="168"></td>
        <td id="LC168" class="blob-line-code js-file-line">            <span class="bp">self</span><span class="o">.</span><span class="n">vprint</span><span class="p">(</span><span class="s">&#39;downloading sort-Xcode-project-file&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L169" class="blob-line-num js-line-number" data-line-number="169"></td>
        <td id="LC169" class="blob-line-code js-file-line">            <span class="n">f_path</span><span class="p">,</span> <span class="n">http_msgs</span> <span class="o">=</span> <span class="n">urlretrieve</span><span class="p">(</span></td>
      </tr>
      <tr>
        <td id="L170" class="blob-line-num js-line-number" data-line-number="170"></td>
        <td id="LC170" class="blob-line-code js-file-line">                <span class="s">&#39;https://raw.githubusercontent.com/truebit/webkit/master/Tools/Scripts/sort-Xcode-project-file&#39;</span><span class="p">,</span></td>
      </tr>
      <tr>
        <td id="L171" class="blob-line-num js-line-number" data-line-number="171"></td>
        <td id="LC171" class="blob-line-code js-file-line">                <span class="n">filename</span><span class="o">=</span><span class="n">sort_script_path</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L172" class="blob-line-num js-line-number" data-line-number="172"></td>
        <td id="LC172" class="blob-line-code js-file-line">            <span class="k">if</span> <span class="nb">int</span><span class="p">(</span><span class="n">http_msgs</span><span class="p">[</span><span class="s">&#39;content-length&#39;</span><span class="p">])</span> <span class="o">&lt;</span> <span class="mi">1000</span><span class="p">:</span>  <span class="c"># current is 6430</span></td>
      </tr>
      <tr>
        <td id="L173" class="blob-line-num js-line-number" data-line-number="173"></td>
        <td id="LC173" class="blob-line-code js-file-line">                <span class="k">raise</span> <span class="ne">SystemExit</span><span class="p">(</span></td>
      </tr>
      <tr>
        <td id="L174" class="blob-line-num js-line-number" data-line-number="174"></td>
        <td id="LC174" class="blob-line-code js-file-line">                    <span class="s">&#39;Cannot download script file from &quot;https://raw.githubusercontent.com/truebit/webkit/master/Tools/Scripts/sort-Xcode-project-file&quot;&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L175" class="blob-line-num js-line-number" data-line-number="175"></td>
        <td id="LC175" class="blob-line-code js-file-line">            <span class="k">for</span> <span class="n">line</span> <span class="ow">in</span> <span class="n">fi_input</span><span class="p">(</span><span class="n">sort_script_path</span><span class="p">,</span> <span class="n">inplace</span><span class="o">=</span><span class="mi">1</span><span class="p">,</span> <span class="n">backup</span><span class="o">=</span><span class="s">&#39;.bak&#39;</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L176" class="blob-line-num js-line-number" data-line-number="176"></td>
        <td id="LC176" class="blob-line-code js-file-line">                <span class="k">print</span><span class="p">(</span><span class="n">line</span><span class="o">.</span><span class="n">replace</span><span class="p">(</span><span class="s">&#39;{24}&#39;</span><span class="p">,</span> <span class="s">&#39;{32}&#39;</span><span class="p">),</span> <span class="n">end</span><span class="o">=</span><span class="s">&#39;&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L177" class="blob-line-num js-line-number" data-line-number="177"></td>
        <td id="LC177" class="blob-line-code js-file-line">            <span class="n">fi_close</span><span class="p">()</span></td>
      </tr>
      <tr>
        <td id="L178" class="blob-line-num js-line-number" data-line-number="178"></td>
        <td id="LC178" class="blob-line-code js-file-line">            <span class="n">unlink</span><span class="p">(</span><span class="n">sort_script_path</span> <span class="o">+</span> <span class="s">&#39;.bak&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L179" class="blob-line-num js-line-number" data-line-number="179"></td>
        <td id="LC179" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">vprint</span><span class="p">(</span><span class="s">&#39;sort project.xpbproj file&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L180" class="blob-line-num js-line-number" data-line-number="180"></td>
        <td id="LC180" class="blob-line-code js-file-line">        <span class="n">sp_cc</span><span class="p">([</span><span class="s">&#39;perl&#39;</span><span class="p">,</span> <span class="n">sort_script_path</span><span class="p">,</span> <span class="bp">self</span><span class="o">.</span><span class="n">xcode_pbxproj_path</span><span class="p">])</span></td>
      </tr>
      <tr>
        <td id="L181" class="blob-line-num js-line-number" data-line-number="181"></td>
        <td id="LC181" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L182" class="blob-line-num js-line-number" data-line-number="182"></td>
        <td id="LC182" class="blob-line-code js-file-line">    <span class="k">def</span> <span class="nf">sort_pbxproj</span><span class="p">(</span><span class="bp">self</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L183" class="blob-line-num js-line-number" data-line-number="183"></td>
        <td id="LC183" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">vprint</span><span class="p">(</span><span class="s">&#39;sort project.xpbproj file&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L184" class="blob-line-num js-line-number" data-line-number="184"></td>
        <td id="LC184" class="blob-line-code js-file-line">        <span class="n">uuid_chars</span> <span class="o">=</span> <span class="nb">len</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="n">main_group_hex</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L185" class="blob-line-num js-line-number" data-line-number="185"></td>
        <td id="LC185" class="blob-line-code js-file-line">        <span class="n">lines</span> <span class="o">=</span> <span class="p">[]</span></td>
      </tr>
      <tr>
        <td id="L186" class="blob-line-num js-line-number" data-line-number="186"></td>
        <td id="LC186" class="blob-line-code js-file-line">        <span class="n">files_start_ptn</span> <span class="o">=</span> <span class="n">re_compile</span><span class="p">(</span><span class="s">&#39;^(\s*)files = \(\s*$&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L187" class="blob-line-num js-line-number" data-line-number="187"></td>
        <td id="LC187" class="blob-line-code js-file-line">        <span class="n">files_key_ptn</span> <span class="o">=</span> <span class="n">re_compile</span><span class="p">(</span><span class="s">&#39;(?&lt;=[A-F0-9]{{{}}} \/\* ).+?(?= in )&#39;</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="n">uuid_chars</span><span class="p">))</span></td>
      </tr>
      <tr>
        <td id="L188" class="blob-line-num js-line-number" data-line-number="188"></td>
        <td id="LC188" class="blob-line-code js-file-line">        <span class="n">fc_end_ptn</span> <span class="o">=</span> <span class="s">&#39;\);&#39;</span></td>
      </tr>
      <tr>
        <td id="L189" class="blob-line-num js-line-number" data-line-number="189"></td>
        <td id="LC189" class="blob-line-code js-file-line">        <span class="n">files_flag</span> <span class="o">=</span> <span class="bp">False</span></td>
      </tr>
      <tr>
        <td id="L190" class="blob-line-num js-line-number" data-line-number="190"></td>
        <td id="LC190" class="blob-line-code js-file-line">        <span class="n">children_start_ptn</span> <span class="o">=</span> <span class="n">re_compile</span><span class="p">(</span><span class="s">&#39;^(\s*)children = \(\s*$&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L191" class="blob-line-num js-line-number" data-line-number="191"></td>
        <td id="LC191" class="blob-line-code js-file-line">        <span class="n">children_pbx_key_ptn</span> <span class="o">=</span> <span class="n">re_compile</span><span class="p">(</span><span class="s">&#39;(?&lt;=[A-F0-9]{{{}}} \/\* ).+?(?= \*\/)&#39;</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="n">uuid_chars</span><span class="p">))</span></td>
      </tr>
      <tr>
        <td id="L192" class="blob-line-num js-line-number" data-line-number="192"></td>
        <td id="LC192" class="blob-line-code js-file-line">        <span class="n">child_flag</span> <span class="o">=</span> <span class="bp">False</span></td>
      </tr>
      <tr>
        <td id="L193" class="blob-line-num js-line-number" data-line-number="193"></td>
        <td id="LC193" class="blob-line-code js-file-line">        <span class="n">pbx_start_ptn</span> <span class="o">=</span> <span class="n">re_compile</span><span class="p">(</span><span class="s">&#39;^.*Begin (PBXBuildFile|PBXFileReference) section.*$&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L194" class="blob-line-num js-line-number" data-line-number="194"></td>
        <td id="LC194" class="blob-line-code js-file-line">        <span class="n">pbx_end_ptn</span> <span class="o">=</span> <span class="p">(</span><span class="s">&#39;^.*End &#39;</span><span class="p">,</span> <span class="s">&#39; section.*$&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L195" class="blob-line-num js-line-number" data-line-number="195"></td>
        <td id="LC195" class="blob-line-code js-file-line">        <span class="n">pbx_flag</span> <span class="o">=</span> <span class="bp">False</span></td>
      </tr>
      <tr>
        <td id="L196" class="blob-line-num js-line-number" data-line-number="196"></td>
        <td id="LC196" class="blob-line-code js-file-line">        <span class="n">last_two</span> <span class="o">=</span> <span class="n">deque</span><span class="p">([])</span></td>
      </tr>
      <tr>
        <td id="L197" class="blob-line-num js-line-number" data-line-number="197"></td>
        <td id="LC197" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L198" class="blob-line-num js-line-number" data-line-number="198"></td>
        <td id="LC198" class="blob-line-code js-file-line">        <span class="k">def</span> <span class="nf">file_dir_cmp</span><span class="p">(</span><span class="n">x</span><span class="p">,</span> <span class="n">y</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L199" class="blob-line-num js-line-number" data-line-number="199"></td>
        <td id="LC199" class="blob-line-code js-file-line">            <span class="k">if</span> <span class="s">&#39;.&#39;</span> <span class="ow">in</span> <span class="n">x</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L200" class="blob-line-num js-line-number" data-line-number="200"></td>
        <td id="LC200" class="blob-line-code js-file-line">                <span class="k">if</span> <span class="s">&#39;.&#39;</span> <span class="ow">in</span> <span class="n">y</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L201" class="blob-line-num js-line-number" data-line-number="201"></td>
        <td id="LC201" class="blob-line-code js-file-line">                    <span class="k">return</span> <span class="nb">cmp</span><span class="p">(</span><span class="n">x</span><span class="p">,</span> <span class="n">y</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L202" class="blob-line-num js-line-number" data-line-number="202"></td>
        <td id="LC202" class="blob-line-code js-file-line">                <span class="k">else</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L203" class="blob-line-num js-line-number" data-line-number="203"></td>
        <td id="LC203" class="blob-line-code js-file-line">                    <span class="k">return</span> <span class="mi">1</span></td>
      </tr>
      <tr>
        <td id="L204" class="blob-line-num js-line-number" data-line-number="204"></td>
        <td id="LC204" class="blob-line-code js-file-line">            <span class="k">else</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L205" class="blob-line-num js-line-number" data-line-number="205"></td>
        <td id="LC205" class="blob-line-code js-file-line">                <span class="k">if</span> <span class="s">&#39;.&#39;</span> <span class="ow">in</span> <span class="n">y</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L206" class="blob-line-num js-line-number" data-line-number="206"></td>
        <td id="LC206" class="blob-line-code js-file-line">                    <span class="k">return</span> <span class="o">-</span><span class="mi">1</span></td>
      </tr>
      <tr>
        <td id="L207" class="blob-line-num js-line-number" data-line-number="207"></td>
        <td id="LC207" class="blob-line-code js-file-line">                <span class="k">else</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L208" class="blob-line-num js-line-number" data-line-number="208"></td>
        <td id="LC208" class="blob-line-code js-file-line">                    <span class="k">return</span> <span class="nb">cmp</span><span class="p">(</span><span class="n">x</span><span class="p">,</span> <span class="n">y</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L209" class="blob-line-num js-line-number" data-line-number="209"></td>
        <td id="LC209" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L210" class="blob-line-num js-line-number" data-line-number="210"></td>
        <td id="LC210" class="blob-line-code js-file-line">        <span class="k">for</span> <span class="n">line</span> <span class="ow">in</span> <span class="n">fi_input</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="n">xcode_pbxproj_path</span><span class="p">,</span> <span class="n">backup</span><span class="o">=</span><span class="s">&#39;.bak&#39;</span><span class="p">,</span> <span class="n">inplace</span><span class="o">=</span><span class="mi">1</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L211" class="blob-line-num js-line-number" data-line-number="211"></td>
        <td id="LC211" class="blob-line-code js-file-line">            <span class="c"># project.pbxproj is an utf-8 encoded file</span></td>
      </tr>
      <tr>
        <td id="L212" class="blob-line-num js-line-number" data-line-number="212"></td>
        <td id="LC212" class="blob-line-code js-file-line">            <span class="n">line</span> <span class="o">=</span> <span class="n">line</span><span class="o">.</span><span class="n">decode</span><span class="p">(</span><span class="s">&#39;utf-8&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L213" class="blob-line-num js-line-number" data-line-number="213"></td>
        <td id="LC213" class="blob-line-code js-file-line">            <span class="n">last_two</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">line</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L214" class="blob-line-num js-line-number" data-line-number="214"></td>
        <td id="LC214" class="blob-line-code js-file-line">            <span class="k">if</span> <span class="nb">len</span><span class="p">(</span><span class="n">last_two</span><span class="p">)</span> <span class="o">&gt;</span> <span class="mi">2</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L215" class="blob-line-num js-line-number" data-line-number="215"></td>
        <td id="LC215" class="blob-line-code js-file-line">                <span class="n">last_two</span><span class="o">.</span><span class="n">popleft</span><span class="p">()</span></td>
      </tr>
      <tr>
        <td id="L216" class="blob-line-num js-line-number" data-line-number="216"></td>
        <td id="LC216" class="blob-line-code js-file-line">            <span class="c"># files search and sort</span></td>
      </tr>
      <tr>
        <td id="L217" class="blob-line-num js-line-number" data-line-number="217"></td>
        <td id="LC217" class="blob-line-code js-file-line">            <span class="n">files_match</span> <span class="o">=</span> <span class="n">files_start_ptn</span><span class="o">.</span><span class="n">search</span><span class="p">(</span><span class="n">line</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L218" class="blob-line-num js-line-number" data-line-number="218"></td>
        <td id="LC218" class="blob-line-code js-file-line">            <span class="k">if</span> <span class="n">files_match</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L219" class="blob-line-num js-line-number" data-line-number="219"></td>
        <td id="LC219" class="blob-line-code js-file-line">                <span class="k">print</span><span class="p">(</span><span class="n">line</span><span class="p">,</span> <span class="n">end</span><span class="o">=</span><span class="s">&#39;&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L220" class="blob-line-num js-line-number" data-line-number="220"></td>
        <td id="LC220" class="blob-line-code js-file-line">                <span class="n">files_flag</span> <span class="o">=</span> <span class="bp">True</span></td>
      </tr>
      <tr>
        <td id="L221" class="blob-line-num js-line-number" data-line-number="221"></td>
        <td id="LC221" class="blob-line-code js-file-line">                <span class="k">if</span> <span class="nb">isinstance</span><span class="p">(</span><span class="n">fc_end_ptn</span><span class="p">,</span> <span class="nb">unicode</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L222" class="blob-line-num js-line-number" data-line-number="222"></td>
        <td id="LC222" class="blob-line-code js-file-line">                    <span class="n">fc_end_ptn</span> <span class="o">=</span> <span class="n">re_compile</span><span class="p">(</span><span class="n">files_match</span><span class="o">.</span><span class="n">group</span><span class="p">(</span><span class="mi">1</span><span class="p">)</span> <span class="o">+</span> <span class="n">fc_end_ptn</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L223" class="blob-line-num js-line-number" data-line-number="223"></td>
        <td id="LC223" class="blob-line-code js-file-line">            <span class="k">if</span> <span class="n">files_flag</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L224" class="blob-line-num js-line-number" data-line-number="224"></td>
        <td id="LC224" class="blob-line-code js-file-line">                <span class="k">if</span> <span class="n">fc_end_ptn</span><span class="o">.</span><span class="n">search</span><span class="p">(</span><span class="n">line</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L225" class="blob-line-num js-line-number" data-line-number="225"></td>
        <td id="LC225" class="blob-line-code js-file-line">                    <span class="k">if</span> <span class="n">lines</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L226" class="blob-line-num js-line-number" data-line-number="226"></td>
        <td id="LC226" class="blob-line-code js-file-line">                        <span class="n">lines</span><span class="o">.</span><span class="n">sort</span><span class="p">(</span><span class="n">key</span><span class="o">=</span><span class="k">lambda</span> <span class="n">file_str</span><span class="p">:</span> <span class="n">files_key_ptn</span><span class="o">.</span><span class="n">search</span><span class="p">(</span><span class="n">file_str</span><span class="p">)</span><span class="o">.</span><span class="n">group</span><span class="p">())</span></td>
      </tr>
      <tr>
        <td id="L227" class="blob-line-num js-line-number" data-line-number="227"></td>
        <td id="LC227" class="blob-line-code js-file-line">                        <span class="k">print</span><span class="p">(</span><span class="s">&#39;&#39;</span><span class="o">.</span><span class="n">join</span><span class="p">(</span><span class="n">lines</span><span class="p">)</span><span class="o">.</span><span class="n">encode</span><span class="p">(</span><span class="s">&#39;utf-8&#39;</span><span class="p">),</span> <span class="n">end</span><span class="o">=</span><span class="s">&#39;&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L228" class="blob-line-num js-line-number" data-line-number="228"></td>
        <td id="LC228" class="blob-line-code js-file-line">                        <span class="n">lines</span> <span class="o">=</span> <span class="p">[]</span></td>
      </tr>
      <tr>
        <td id="L229" class="blob-line-num js-line-number" data-line-number="229"></td>
        <td id="LC229" class="blob-line-code js-file-line">                    <span class="n">files_flag</span> <span class="o">=</span> <span class="bp">False</span></td>
      </tr>
      <tr>
        <td id="L230" class="blob-line-num js-line-number" data-line-number="230"></td>
        <td id="LC230" class="blob-line-code js-file-line">                    <span class="n">fc_end_ptn</span> <span class="o">=</span> <span class="s">&#39;\);&#39;</span></td>
      </tr>
      <tr>
        <td id="L231" class="blob-line-num js-line-number" data-line-number="231"></td>
        <td id="LC231" class="blob-line-code js-file-line">                <span class="k">elif</span> <span class="n">files_key_ptn</span><span class="o">.</span><span class="n">search</span><span class="p">(</span><span class="n">line</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L232" class="blob-line-num js-line-number" data-line-number="232"></td>
        <td id="LC232" class="blob-line-code js-file-line">                    <span class="n">lines</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">line</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L233" class="blob-line-num js-line-number" data-line-number="233"></td>
        <td id="LC233" class="blob-line-code js-file-line">            <span class="c"># children search and sort</span></td>
      </tr>
      <tr>
        <td id="L234" class="blob-line-num js-line-number" data-line-number="234"></td>
        <td id="LC234" class="blob-line-code js-file-line">            <span class="n">children_match</span> <span class="o">=</span> <span class="n">children_start_ptn</span><span class="o">.</span><span class="n">search</span><span class="p">(</span><span class="n">line</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L235" class="blob-line-num js-line-number" data-line-number="235"></td>
        <td id="LC235" class="blob-line-code js-file-line">            <span class="k">if</span> <span class="n">children_match</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L236" class="blob-line-num js-line-number" data-line-number="236"></td>
        <td id="LC236" class="blob-line-code js-file-line">                <span class="k">print</span><span class="p">(</span><span class="n">line</span><span class="p">,</span> <span class="n">end</span><span class="o">=</span><span class="s">&#39;&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L237" class="blob-line-num js-line-number" data-line-number="237"></td>
        <td id="LC237" class="blob-line-code js-file-line">                <span class="n">child_flag</span> <span class="o">=</span> <span class="bp">True</span></td>
      </tr>
      <tr>
        <td id="L238" class="blob-line-num js-line-number" data-line-number="238"></td>
        <td id="LC238" class="blob-line-code js-file-line">                <span class="k">if</span> <span class="nb">isinstance</span><span class="p">(</span><span class="n">fc_end_ptn</span><span class="p">,</span> <span class="nb">unicode</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L239" class="blob-line-num js-line-number" data-line-number="239"></td>
        <td id="LC239" class="blob-line-code js-file-line">                    <span class="n">fc_end_ptn</span> <span class="o">=</span> <span class="n">re_compile</span><span class="p">(</span><span class="n">children_match</span><span class="o">.</span><span class="n">group</span><span class="p">(</span><span class="mi">1</span><span class="p">)</span> <span class="o">+</span> <span class="n">fc_end_ptn</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L240" class="blob-line-num js-line-number" data-line-number="240"></td>
        <td id="LC240" class="blob-line-code js-file-line">            <span class="k">if</span> <span class="n">child_flag</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L241" class="blob-line-num js-line-number" data-line-number="241"></td>
        <td id="LC241" class="blob-line-code js-file-line">                <span class="k">if</span> <span class="n">fc_end_ptn</span><span class="o">.</span><span class="n">search</span><span class="p">(</span><span class="n">line</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L242" class="blob-line-num js-line-number" data-line-number="242"></td>
        <td id="LC242" class="blob-line-code js-file-line">                    <span class="k">if</span> <span class="n">lines</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L243" class="blob-line-num js-line-number" data-line-number="243"></td>
        <td id="LC243" class="blob-line-code js-file-line">                        <span class="k">if</span> <span class="bp">self</span><span class="o">.</span><span class="n">main_group_hex</span> <span class="ow">not</span> <span class="ow">in</span> <span class="n">last_two</span><span class="p">[</span><span class="mi">0</span><span class="p">]:</span></td>
      </tr>
      <tr>
        <td id="L244" class="blob-line-num js-line-number" data-line-number="244"></td>
        <td id="LC244" class="blob-line-code js-file-line">                            <span class="n">lines</span><span class="o">.</span><span class="n">sort</span><span class="p">(</span><span class="n">key</span><span class="o">=</span><span class="k">lambda</span> <span class="n">file_str</span><span class="p">:</span> <span class="n">children_pbx_key_ptn</span><span class="o">.</span><span class="n">search</span><span class="p">(</span><span class="n">file_str</span><span class="p">)</span><span class="o">.</span><span class="n">group</span><span class="p">(),</span></td>
      </tr>
      <tr>
        <td id="L245" class="blob-line-num js-line-number" data-line-number="245"></td>
        <td id="LC245" class="blob-line-code js-file-line">                                       <span class="nb">cmp</span><span class="o">=</span><span class="n">file_dir_cmp</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L246" class="blob-line-num js-line-number" data-line-number="246"></td>
        <td id="LC246" class="blob-line-code js-file-line">                        <span class="k">print</span><span class="p">(</span><span class="s">&#39;&#39;</span><span class="o">.</span><span class="n">join</span><span class="p">(</span><span class="n">lines</span><span class="p">)</span><span class="o">.</span><span class="n">encode</span><span class="p">(</span><span class="s">&#39;utf-8&#39;</span><span class="p">),</span> <span class="n">end</span><span class="o">=</span><span class="s">&#39;&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L247" class="blob-line-num js-line-number" data-line-number="247"></td>
        <td id="LC247" class="blob-line-code js-file-line">                        <span class="n">lines</span> <span class="o">=</span> <span class="p">[]</span></td>
      </tr>
      <tr>
        <td id="L248" class="blob-line-num js-line-number" data-line-number="248"></td>
        <td id="LC248" class="blob-line-code js-file-line">                    <span class="n">child_flag</span> <span class="o">=</span> <span class="bp">False</span></td>
      </tr>
      <tr>
        <td id="L249" class="blob-line-num js-line-number" data-line-number="249"></td>
        <td id="LC249" class="blob-line-code js-file-line">                    <span class="n">fc_end_ptn</span> <span class="o">=</span> <span class="s">&#39;\);&#39;</span></td>
      </tr>
      <tr>
        <td id="L250" class="blob-line-num js-line-number" data-line-number="250"></td>
        <td id="LC250" class="blob-line-code js-file-line">                <span class="k">elif</span> <span class="n">children_pbx_key_ptn</span><span class="o">.</span><span class="n">search</span><span class="p">(</span><span class="n">line</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L251" class="blob-line-num js-line-number" data-line-number="251"></td>
        <td id="LC251" class="blob-line-code js-file-line">                    <span class="n">lines</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">line</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L252" class="blob-line-num js-line-number" data-line-number="252"></td>
        <td id="LC252" class="blob-line-code js-file-line">            <span class="c"># PBX search and sort</span></td>
      </tr>
      <tr>
        <td id="L253" class="blob-line-num js-line-number" data-line-number="253"></td>
        <td id="LC253" class="blob-line-code js-file-line">            <span class="n">pbx_match</span> <span class="o">=</span> <span class="n">pbx_start_ptn</span><span class="o">.</span><span class="n">search</span><span class="p">(</span><span class="n">line</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L254" class="blob-line-num js-line-number" data-line-number="254"></td>
        <td id="LC254" class="blob-line-code js-file-line">            <span class="k">if</span> <span class="n">pbx_match</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L255" class="blob-line-num js-line-number" data-line-number="255"></td>
        <td id="LC255" class="blob-line-code js-file-line">                <span class="k">print</span><span class="p">(</span><span class="n">line</span><span class="p">,</span> <span class="n">end</span><span class="o">=</span><span class="s">&#39;&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L256" class="blob-line-num js-line-number" data-line-number="256"></td>
        <td id="LC256" class="blob-line-code js-file-line">                <span class="n">pbx_flag</span> <span class="o">=</span> <span class="bp">True</span></td>
      </tr>
      <tr>
        <td id="L257" class="blob-line-num js-line-number" data-line-number="257"></td>
        <td id="LC257" class="blob-line-code js-file-line">                <span class="k">if</span> <span class="nb">isinstance</span><span class="p">(</span><span class="n">pbx_end_ptn</span><span class="p">,</span> <span class="nb">tuple</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L258" class="blob-line-num js-line-number" data-line-number="258"></td>
        <td id="LC258" class="blob-line-code js-file-line">                    <span class="n">pbx_end_ptn</span> <span class="o">=</span> <span class="n">re_compile</span><span class="p">(</span><span class="n">pbx_match</span><span class="o">.</span><span class="n">group</span><span class="p">(</span><span class="mi">1</span><span class="p">)</span><span class="o">.</span><span class="n">join</span><span class="p">(</span><span class="n">pbx_end_ptn</span><span class="p">))</span></td>
      </tr>
      <tr>
        <td id="L259" class="blob-line-num js-line-number" data-line-number="259"></td>
        <td id="LC259" class="blob-line-code js-file-line">            <span class="k">if</span> <span class="n">pbx_flag</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L260" class="blob-line-num js-line-number" data-line-number="260"></td>
        <td id="LC260" class="blob-line-code js-file-line">                <span class="k">if</span> <span class="n">pbx_end_ptn</span><span class="o">.</span><span class="n">search</span><span class="p">(</span><span class="n">line</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L261" class="blob-line-num js-line-number" data-line-number="261"></td>
        <td id="LC261" class="blob-line-code js-file-line">                    <span class="k">if</span> <span class="n">lines</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L262" class="blob-line-num js-line-number" data-line-number="262"></td>
        <td id="LC262" class="blob-line-code js-file-line">                        <span class="n">lines</span><span class="o">.</span><span class="n">sort</span><span class="p">(</span><span class="n">key</span><span class="o">=</span><span class="k">lambda</span> <span class="n">file_str</span><span class="p">:</span> <span class="n">children_pbx_key_ptn</span><span class="o">.</span><span class="n">search</span><span class="p">(</span><span class="n">file_str</span><span class="p">)</span><span class="o">.</span><span class="n">group</span><span class="p">())</span></td>
      </tr>
      <tr>
        <td id="L263" class="blob-line-num js-line-number" data-line-number="263"></td>
        <td id="LC263" class="blob-line-code js-file-line">                        <span class="k">print</span><span class="p">(</span><span class="s">&#39;&#39;</span><span class="o">.</span><span class="n">join</span><span class="p">(</span><span class="n">lines</span><span class="p">)</span><span class="o">.</span><span class="n">encode</span><span class="p">(</span><span class="s">&#39;utf-8&#39;</span><span class="p">),</span> <span class="n">end</span><span class="o">=</span><span class="s">&#39;&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L264" class="blob-line-num js-line-number" data-line-number="264"></td>
        <td id="LC264" class="blob-line-code js-file-line">                        <span class="n">lines</span> <span class="o">=</span> <span class="p">[]</span></td>
      </tr>
      <tr>
        <td id="L265" class="blob-line-num js-line-number" data-line-number="265"></td>
        <td id="LC265" class="blob-line-code js-file-line">                    <span class="n">pbx_flag</span> <span class="o">=</span> <span class="bp">False</span></td>
      </tr>
      <tr>
        <td id="L266" class="blob-line-num js-line-number" data-line-number="266"></td>
        <td id="LC266" class="blob-line-code js-file-line">                    <span class="n">pbx_end_ptn</span> <span class="o">=</span> <span class="p">(</span><span class="s">&#39;^.*End &#39;</span><span class="p">,</span> <span class="s">&#39; section.*&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L267" class="blob-line-num js-line-number" data-line-number="267"></td>
        <td id="LC267" class="blob-line-code js-file-line">                <span class="k">elif</span> <span class="n">children_pbx_key_ptn</span><span class="o">.</span><span class="n">search</span><span class="p">(</span><span class="n">line</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L268" class="blob-line-num js-line-number" data-line-number="268"></td>
        <td id="LC268" class="blob-line-code js-file-line">                    <span class="n">lines</span><span class="o">.</span><span class="n">append</span><span class="p">(</span><span class="n">line</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L269" class="blob-line-num js-line-number" data-line-number="269"></td>
        <td id="LC269" class="blob-line-code js-file-line">            <span class="c"># normal output</span></td>
      </tr>
      <tr>
        <td id="L270" class="blob-line-num js-line-number" data-line-number="270"></td>
        <td id="LC270" class="blob-line-code js-file-line">            <span class="k">if</span> <span class="ow">not</span> <span class="p">(</span><span class="n">files_flag</span> <span class="ow">or</span> <span class="n">child_flag</span> <span class="ow">or</span> <span class="n">pbx_flag</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L271" class="blob-line-num js-line-number" data-line-number="271"></td>
        <td id="LC271" class="blob-line-code js-file-line">                <span class="k">print</span><span class="p">(</span><span class="n">line</span><span class="p">,</span> <span class="n">end</span><span class="o">=</span><span class="s">&#39;&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L272" class="blob-line-num js-line-number" data-line-number="272"></td>
        <td id="LC272" class="blob-line-code js-file-line">        <span class="n">fi_close</span><span class="p">()</span></td>
      </tr>
      <tr>
        <td id="L273" class="blob-line-num js-line-number" data-line-number="273"></td>
        <td id="LC273" class="blob-line-code js-file-line">        <span class="n">tmp_path</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">xcode_pbxproj_path</span> <span class="o">+</span> <span class="s">&#39;.bak&#39;</span></td>
      </tr>
      <tr>
        <td id="L274" class="blob-line-num js-line-number" data-line-number="274"></td>
        <td id="LC274" class="blob-line-code js-file-line">        <span class="k">if</span> <span class="n">filecmp_cmp</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="n">xcode_pbxproj_path</span><span class="p">,</span> <span class="n">tmp_path</span><span class="p">,</span> <span class="n">shallow</span><span class="o">=</span><span class="bp">False</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L275" class="blob-line-num js-line-number" data-line-number="275"></td>
        <td id="LC275" class="blob-line-code js-file-line">            <span class="n">unlink</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="n">xcode_pbxproj_path</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L276" class="blob-line-num js-line-number" data-line-number="276"></td>
        <td id="LC276" class="blob-line-code js-file-line">            <span class="n">rename</span><span class="p">(</span><span class="n">tmp_path</span><span class="p">,</span> <span class="bp">self</span><span class="o">.</span><span class="n">xcode_pbxproj_path</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L277" class="blob-line-num js-line-number" data-line-number="277"></td>
        <td id="LC277" class="blob-line-code js-file-line">            <span class="k">print</span><span class="p">(</span><span class="s">&#39;Ignore sort, no changes made to&#39;</span><span class="p">,</span> <span class="bp">self</span><span class="o">.</span><span class="n">xcode_pbxproj_path</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L278" class="blob-line-num js-line-number" data-line-number="278"></td>
        <td id="LC278" class="blob-line-code js-file-line">        <span class="k">else</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L279" class="blob-line-num js-line-number" data-line-number="279"></td>
        <td id="LC279" class="blob-line-code js-file-line">            <span class="n">unlink</span><span class="p">(</span><span class="n">tmp_path</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L280" class="blob-line-num js-line-number" data-line-number="280"></td>
        <td id="LC280" class="blob-line-code js-file-line">            <span class="k">print</span><span class="p">(</span><span class="s">&#39;Sort done&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L281" class="blob-line-num js-line-number" data-line-number="281"></td>
        <td id="LC281" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L282" class="blob-line-num js-line-number" data-line-number="282"></td>
        <td id="LC282" class="blob-line-code js-file-line">    <span class="k">def</span> <span class="nf">__unique_project</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">project_hex</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L283" class="blob-line-num js-line-number" data-line-number="283"></td>
        <td id="LC283" class="blob-line-code js-file-line">        <span class="sd">&#39;&#39;&#39;PBXProject. It is root itself, no parents to it&#39;&#39;&#39;</span></td>
      </tr>
      <tr>
        <td id="L284" class="blob-line-num js-line-number" data-line-number="284"></td>
        <td id="LC284" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">vprint</span><span class="p">(</span><span class="s">&#39;uniquify PBXProject&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L285" class="blob-line-num js-line-number" data-line-number="285"></td>
        <td id="LC285" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">vprint</span><span class="p">(</span><span class="s">&#39;uniquify PBXGroup and PBXFileRef&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L286" class="blob-line-num js-line-number" data-line-number="286"></td>
        <td id="LC286" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">__unique_group_or_ref</span><span class="p">(</span><span class="n">project_hex</span><span class="p">,</span> <span class="bp">self</span><span class="o">.</span><span class="n">main_group_hex</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L287" class="blob-line-num js-line-number" data-line-number="287"></td>
        <td id="LC287" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">vprint</span><span class="p">(</span><span class="s">&#39;uniquify XCConfigurationList&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L288" class="blob-line-num js-line-number" data-line-number="288"></td>
        <td id="LC288" class="blob-line-code js-file-line">        <span class="n">bcl_hex</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">root_node</span><span class="p">[</span><span class="s">&#39;buildConfigurationList&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L289" class="blob-line-num js-line-number" data-line-number="289"></td>
        <td id="LC289" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">__unique_build_configuration_list</span><span class="p">(</span><span class="n">project_hex</span><span class="p">,</span> <span class="n">bcl_hex</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L290" class="blob-line-num js-line-number" data-line-number="290"></td>
        <td id="LC290" class="blob-line-code js-file-line">        <span class="n">subprojects_list</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">root_node</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="s">&#39;projectReferences&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L291" class="blob-line-num js-line-number" data-line-number="291"></td>
        <td id="LC291" class="blob-line-code js-file-line">        <span class="k">if</span> <span class="n">subprojects_list</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L292" class="blob-line-num js-line-number" data-line-number="292"></td>
        <td id="LC292" class="blob-line-code js-file-line">            <span class="bp">self</span><span class="o">.</span><span class="n">vprint</span><span class="p">(</span><span class="s">&#39;uniquify Subprojects&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L293" class="blob-line-num js-line-number" data-line-number="293"></td>
        <td id="LC293" class="blob-line-code js-file-line">            <span class="k">for</span> <span class="n">subproject_dict</span> <span class="ow">in</span> <span class="n">subprojects_list</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L294" class="blob-line-num js-line-number" data-line-number="294"></td>
        <td id="LC294" class="blob-line-code js-file-line">                <span class="n">product_group_hex</span> <span class="o">=</span> <span class="n">subproject_dict</span><span class="p">[</span><span class="s">&#39;ProductGroup&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L295" class="blob-line-num js-line-number" data-line-number="295"></td>
        <td id="LC295" class="blob-line-code js-file-line">                <span class="n">project_ref_parent_hex</span> <span class="o">=</span> <span class="n">subproject_dict</span><span class="p">[</span><span class="s">&#39;ProjectRef&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L296" class="blob-line-num js-line-number" data-line-number="296"></td>
        <td id="LC296" class="blob-line-code js-file-line">                <span class="bp">self</span><span class="o">.</span><span class="n">__unique_group_or_ref</span><span class="p">(</span><span class="n">project_ref_parent_hex</span><span class="p">,</span> <span class="n">product_group_hex</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L297" class="blob-line-num js-line-number" data-line-number="297"></td>
        <td id="LC297" class="blob-line-code js-file-line">        <span class="n">targets_list</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">root_node</span><span class="p">[</span><span class="s">&#39;targets&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L298" class="blob-line-num js-line-number" data-line-number="298"></td>
        <td id="LC298" class="blob-line-code js-file-line">        <span class="k">for</span> <span class="n">target_hex</span> <span class="ow">in</span> <span class="n">targets_list</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L299" class="blob-line-num js-line-number" data-line-number="299"></td>
        <td id="LC299" class="blob-line-code js-file-line">            <span class="bp">self</span><span class="o">.</span><span class="n">__unique_target</span><span class="p">(</span><span class="n">project_hex</span><span class="p">,</span> <span class="n">target_hex</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L300" class="blob-line-num js-line-number" data-line-number="300"></td>
        <td id="LC300" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L301" class="blob-line-num js-line-number" data-line-number="301"></td>
        <td id="LC301" class="blob-line-code js-file-line">    <span class="k">def</span> <span class="nf">__unique_build_configuration_list</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">parent_hex</span><span class="p">,</span> <span class="n">build_configuration_list_hex</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L302" class="blob-line-num js-line-number" data-line-number="302"></td>
        <td id="LC302" class="blob-line-code js-file-line">        <span class="sd">&#39;&#39;&#39;XCConfigurationList&#39;&#39;&#39;</span></td>
      </tr>
      <tr>
        <td id="L303" class="blob-line-num js-line-number" data-line-number="303"></td>
        <td id="LC303" class="blob-line-code js-file-line">        <span class="n">cur_path_key</span> <span class="o">=</span> <span class="s">&#39;defaultConfigurationName&#39;</span></td>
      </tr>
      <tr>
        <td id="L304" class="blob-line-num js-line-number" data-line-number="304"></td>
        <td id="LC304" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">__set_to_result</span><span class="p">(</span><span class="n">parent_hex</span><span class="p">,</span> <span class="n">build_configuration_list_hex</span><span class="p">,</span> <span class="n">cur_path_key</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L305" class="blob-line-num js-line-number" data-line-number="305"></td>
        <td id="LC305" class="blob-line-code js-file-line">        <span class="n">build_configuration_list_node</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">nodes</span><span class="p">[</span><span class="n">build_configuration_list_hex</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L306" class="blob-line-num js-line-number" data-line-number="306"></td>
        <td id="LC306" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">vprint</span><span class="p">(</span><span class="s">&#39;uniquify XCConfiguration&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L307" class="blob-line-num js-line-number" data-line-number="307"></td>
        <td id="LC307" class="blob-line-code js-file-line">        <span class="k">for</span> <span class="n">build_configuration_hex</span> <span class="ow">in</span> <span class="n">build_configuration_list_node</span><span class="p">[</span><span class="s">&#39;buildConfigurations&#39;</span><span class="p">]:</span></td>
      </tr>
      <tr>
        <td id="L308" class="blob-line-num js-line-number" data-line-number="308"></td>
        <td id="LC308" class="blob-line-code js-file-line">            <span class="bp">self</span><span class="o">.</span><span class="n">__unique_build_configuration</span><span class="p">(</span><span class="n">build_configuration_list_hex</span><span class="p">,</span> <span class="n">build_configuration_hex</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L309" class="blob-line-num js-line-number" data-line-number="309"></td>
        <td id="LC309" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L310" class="blob-line-num js-line-number" data-line-number="310"></td>
        <td id="LC310" class="blob-line-code js-file-line">    <span class="k">def</span> <span class="nf">__unique_build_configuration</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">parent_hex</span><span class="p">,</span> <span class="n">build_configuration_hex</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L311" class="blob-line-num js-line-number" data-line-number="311"></td>
        <td id="LC311" class="blob-line-code js-file-line">        <span class="sd">&#39;&#39;&#39;XCBuildConfiguration&#39;&#39;&#39;</span></td>
      </tr>
      <tr>
        <td id="L312" class="blob-line-num js-line-number" data-line-number="312"></td>
        <td id="LC312" class="blob-line-code js-file-line">        <span class="n">cur_path_key</span> <span class="o">=</span> <span class="s">&#39;name&#39;</span></td>
      </tr>
      <tr>
        <td id="L313" class="blob-line-num js-line-number" data-line-number="313"></td>
        <td id="LC313" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">__set_to_result</span><span class="p">(</span><span class="n">parent_hex</span><span class="p">,</span> <span class="n">build_configuration_hex</span><span class="p">,</span> <span class="n">cur_path_key</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L314" class="blob-line-num js-line-number" data-line-number="314"></td>
        <td id="LC314" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L315" class="blob-line-num js-line-number" data-line-number="315"></td>
        <td id="LC315" class="blob-line-code js-file-line">    <span class="k">def</span> <span class="nf">__unique_target</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">parent_hex</span><span class="p">,</span> <span class="n">target_hex</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L316" class="blob-line-num js-line-number" data-line-number="316"></td>
        <td id="LC316" class="blob-line-code js-file-line">        <span class="sd">&#39;&#39;&#39;PBXNativeTarget&#39;&#39;&#39;</span></td>
      </tr>
      <tr>
        <td id="L317" class="blob-line-num js-line-number" data-line-number="317"></td>
        <td id="LC317" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">vprint</span><span class="p">(</span><span class="s">&#39;uniquify PBXNativeTarget&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L318" class="blob-line-num js-line-number" data-line-number="318"></td>
        <td id="LC318" class="blob-line-code js-file-line">        <span class="n">cur_path_key</span> <span class="o">=</span> <span class="p">(</span><span class="s">&#39;productName&#39;</span><span class="p">,</span> <span class="s">&#39;name&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L319" class="blob-line-num js-line-number" data-line-number="319"></td>
        <td id="LC319" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">__set_to_result</span><span class="p">(</span><span class="n">parent_hex</span><span class="p">,</span> <span class="n">target_hex</span><span class="p">,</span> <span class="n">cur_path_key</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L320" class="blob-line-num js-line-number" data-line-number="320"></td>
        <td id="LC320" class="blob-line-code js-file-line">        <span class="n">current_node</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">nodes</span><span class="p">[</span><span class="n">target_hex</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L321" class="blob-line-num js-line-number" data-line-number="321"></td>
        <td id="LC321" class="blob-line-code js-file-line">        <span class="n">bcl_hex</span> <span class="o">=</span> <span class="n">current_node</span><span class="p">[</span><span class="s">&#39;buildConfigurationList&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L322" class="blob-line-num js-line-number" data-line-number="322"></td>
        <td id="LC322" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">__unique_build_configuration_list</span><span class="p">(</span><span class="n">target_hex</span><span class="p">,</span> <span class="n">bcl_hex</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L323" class="blob-line-num js-line-number" data-line-number="323"></td>
        <td id="LC323" class="blob-line-code js-file-line">        <span class="n">dependencies_list</span> <span class="o">=</span> <span class="n">current_node</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="s">&#39;dependencies&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L324" class="blob-line-num js-line-number" data-line-number="324"></td>
        <td id="LC324" class="blob-line-code js-file-line">        <span class="k">if</span> <span class="n">dependencies_list</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L325" class="blob-line-num js-line-number" data-line-number="325"></td>
        <td id="LC325" class="blob-line-code js-file-line">            <span class="k">for</span> <span class="n">dependency_hex</span> <span class="ow">in</span> <span class="n">dependencies_list</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L326" class="blob-line-num js-line-number" data-line-number="326"></td>
        <td id="LC326" class="blob-line-code js-file-line">                <span class="bp">self</span><span class="o">.</span><span class="n">__unique_target_dependency</span><span class="p">(</span><span class="n">target_hex</span><span class="p">,</span> <span class="n">dependency_hex</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L327" class="blob-line-num js-line-number" data-line-number="327"></td>
        <td id="LC327" class="blob-line-code js-file-line">        <span class="n">build_phases_list</span> <span class="o">=</span> <span class="n">current_node</span><span class="p">[</span><span class="s">&#39;buildPhases&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L328" class="blob-line-num js-line-number" data-line-number="328"></td>
        <td id="LC328" class="blob-line-code js-file-line">        <span class="k">for</span> <span class="n">build_phase_hex</span> <span class="ow">in</span> <span class="n">build_phases_list</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L329" class="blob-line-num js-line-number" data-line-number="329"></td>
        <td id="LC329" class="blob-line-code js-file-line">            <span class="bp">self</span><span class="o">.</span><span class="n">__unique_build_phase</span><span class="p">(</span><span class="n">target_hex</span><span class="p">,</span> <span class="n">build_phase_hex</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L330" class="blob-line-num js-line-number" data-line-number="330"></td>
        <td id="LC330" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L331" class="blob-line-num js-line-number" data-line-number="331"></td>
        <td id="LC331" class="blob-line-code js-file-line">    <span class="k">def</span> <span class="nf">__unique_target_dependency</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">parent_hex</span><span class="p">,</span> <span class="n">target_dependency_hex</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L332" class="blob-line-num js-line-number" data-line-number="332"></td>
        <td id="LC332" class="blob-line-code js-file-line">        <span class="sd">&#39;&#39;&#39;PBXTargetDependency&#39;&#39;&#39;</span></td>
      </tr>
      <tr>
        <td id="L333" class="blob-line-num js-line-number" data-line-number="333"></td>
        <td id="LC333" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">__set_to_result</span><span class="p">(</span><span class="n">parent_hex</span><span class="p">,</span> <span class="n">target_dependency_hex</span><span class="p">,</span> <span class="s">&#39;name&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L334" class="blob-line-num js-line-number" data-line-number="334"></td>
        <td id="LC334" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">__unique_container_item_proxy</span><span class="p">(</span><span class="n">target_dependency_hex</span><span class="p">,</span> <span class="bp">self</span><span class="o">.</span><span class="n">nodes</span><span class="p">[</span><span class="n">target_dependency_hex</span><span class="p">][</span><span class="s">&#39;targetProxy&#39;</span><span class="p">])</span></td>
      </tr>
      <tr>
        <td id="L335" class="blob-line-num js-line-number" data-line-number="335"></td>
        <td id="LC335" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L336" class="blob-line-num js-line-number" data-line-number="336"></td>
        <td id="LC336" class="blob-line-code js-file-line">    <span class="k">def</span> <span class="nf">__unique_container_item_proxy</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">parent_hex</span><span class="p">,</span> <span class="n">container_item_proxy_hex</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L337" class="blob-line-num js-line-number" data-line-number="337"></td>
        <td id="LC337" class="blob-line-code js-file-line">        <span class="sd">&#39;&#39;&#39;PBXContainerItemProxy&#39;&#39;&#39;</span></td>
      </tr>
      <tr>
        <td id="L338" class="blob-line-num js-line-number" data-line-number="338"></td>
        <td id="LC338" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">vprint</span><span class="p">(</span><span class="s">&#39;uniquify PBXContainerItemProxy&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L339" class="blob-line-num js-line-number" data-line-number="339"></td>
        <td id="LC339" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">__set_to_result</span><span class="p">(</span><span class="n">parent_hex</span><span class="p">,</span> <span class="n">container_item_proxy_hex</span><span class="p">,</span> <span class="s">&#39;remoteInfo&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L340" class="blob-line-num js-line-number" data-line-number="340"></td>
        <td id="LC340" class="blob-line-code js-file-line">        <span class="n">cur_path</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">__result</span><span class="p">[</span><span class="n">container_item_proxy_hex</span><span class="p">][</span><span class="s">&#39;path&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L341" class="blob-line-num js-line-number" data-line-number="341"></td>
        <td id="LC341" class="blob-line-code js-file-line">        <span class="n">current_node</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">nodes</span><span class="p">[</span><span class="n">container_item_proxy_hex</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L342" class="blob-line-num js-line-number" data-line-number="342"></td>
        <td id="LC342" class="blob-line-code js-file-line">        <span class="c"># re-calculate remoteGlobalIDString to a new length 32 MD5 digest</span></td>
      </tr>
      <tr>
        <td id="L343" class="blob-line-num js-line-number" data-line-number="343"></td>
        <td id="LC343" class="blob-line-code js-file-line">        <span class="n">remote_global_id_hex</span> <span class="o">=</span> <span class="n">current_node</span><span class="p">[</span><span class="s">&#39;remoteGlobalIDString&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L344" class="blob-line-num js-line-number" data-line-number="344"></td>
        <td id="LC344" class="blob-line-code js-file-line">        <span class="n">portal_hex</span> <span class="o">=</span> <span class="n">current_node</span><span class="p">[</span><span class="s">&#39;containerPortal&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L345" class="blob-line-num js-line-number" data-line-number="345"></td>
        <td id="LC345" class="blob-line-code js-file-line">        <span class="n">portal_path</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">__result</span><span class="p">[</span><span class="n">portal_hex</span><span class="p">][</span><span class="s">&#39;path&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L346" class="blob-line-num js-line-number" data-line-number="346"></td>
        <td id="LC346" class="blob-line-code js-file-line">        <span class="n">new_rg_id_path</span> <span class="o">=</span> <span class="s">&#39;{}+{}&#39;</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="n">cur_path</span><span class="p">,</span> <span class="n">portal_path</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L347" class="blob-line-num js-line-number" data-line-number="347"></td>
        <td id="LC347" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">__result</span><span class="o">.</span><span class="n">update</span><span class="p">({</span></td>
      </tr>
      <tr>
        <td id="L348" class="blob-line-num js-line-number" data-line-number="348"></td>
        <td id="LC348" class="blob-line-code js-file-line">            <span class="n">remote_global_id_hex</span><span class="p">:</span> <span class="p">{</span><span class="s">&#39;path&#39;</span><span class="p">:</span> <span class="n">new_rg_id_path</span><span class="p">,</span></td>
      </tr>
      <tr>
        <td id="L349" class="blob-line-num js-line-number" data-line-number="349"></td>
        <td id="LC349" class="blob-line-code js-file-line">                                   <span class="s">&#39;new_key&#39;</span><span class="p">:</span> <span class="n">md5_hex</span><span class="p">(</span><span class="n">new_rg_id_path</span><span class="p">),</span></td>
      </tr>
      <tr>
        <td id="L350" class="blob-line-num js-line-number" data-line-number="350"></td>
        <td id="LC350" class="blob-line-code js-file-line">                                   <span class="s">&#39;type&#39;</span><span class="p">:</span> <span class="s">&#39;{}#{}&#39;</span><span class="o">.</span><span class="n">format</span><span class="p">(</span><span class="bp">self</span><span class="o">.</span><span class="n">nodes</span><span class="p">[</span><span class="n">container_item_proxy_hex</span><span class="p">][</span><span class="s">&#39;isa&#39;</span><span class="p">],</span></td>
      </tr>
      <tr>
        <td id="L351" class="blob-line-num js-line-number" data-line-number="351"></td>
        <td id="LC351" class="blob-line-code js-file-line">                                                          <span class="s">&#39;remoteGlobalIDString&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L352" class="blob-line-num js-line-number" data-line-number="352"></td>
        <td id="LC352" class="blob-line-code js-file-line">            <span class="p">}</span></td>
      </tr>
      <tr>
        <td id="L353" class="blob-line-num js-line-number" data-line-number="353"></td>
        <td id="LC353" class="blob-line-code js-file-line">        <span class="p">})</span></td>
      </tr>
      <tr>
        <td id="L354" class="blob-line-num js-line-number" data-line-number="354"></td>
        <td id="LC354" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L355" class="blob-line-num js-line-number" data-line-number="355"></td>
        <td id="LC355" class="blob-line-code js-file-line">    <span class="k">def</span> <span class="nf">__unique_build_phase</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">parent_hex</span><span class="p">,</span> <span class="n">build_phase_hex</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L356" class="blob-line-num js-line-number" data-line-number="356"></td>
        <td id="LC356" class="blob-line-code js-file-line">        <span class="sd">&#39;&#39;&#39;PBXSourcesBuildPhase PBXFrameworksBuildPhase PBXResourcesBuildPhase PBXCopyFilesBuildPhase&#39;&#39;&#39;</span></td>
      </tr>
      <tr>
        <td id="L357" class="blob-line-num js-line-number" data-line-number="357"></td>
        <td id="LC357" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">vprint</span><span class="p">(</span><span class="s">&#39;uniquify PBXSourcesBuildPhase, PBXFrameworksBuildPhase and PBXResourcesBuildPhase&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L358" class="blob-line-num js-line-number" data-line-number="358"></td>
        <td id="LC358" class="blob-line-code js-file-line">        <span class="n">current_node</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">nodes</span><span class="p">[</span><span class="n">build_phase_hex</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L359" class="blob-line-num js-line-number" data-line-number="359"></td>
        <td id="LC359" class="blob-line-code js-file-line">        <span class="c"># no useful key, use its isa value</span></td>
      </tr>
      <tr>
        <td id="L360" class="blob-line-num js-line-number" data-line-number="360"></td>
        <td id="LC360" class="blob-line-code js-file-line">        <span class="n">cur_path_key</span> <span class="o">=</span> <span class="n">current_node</span><span class="p">[</span><span class="s">&#39;isa&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L361" class="blob-line-num js-line-number" data-line-number="361"></td>
        <td id="LC361" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">__set_to_result</span><span class="p">(</span><span class="n">parent_hex</span><span class="p">,</span> <span class="n">build_phase_hex</span><span class="p">,</span> <span class="n">cur_path_key</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L362" class="blob-line-num js-line-number" data-line-number="362"></td>
        <td id="LC362" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">vprint</span><span class="p">(</span><span class="s">&#39;uniquify PBXBuildFile&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L363" class="blob-line-num js-line-number" data-line-number="363"></td>
        <td id="LC363" class="blob-line-code js-file-line">        <span class="k">for</span> <span class="n">build_file_hex</span> <span class="ow">in</span> <span class="n">current_node</span><span class="p">[</span><span class="s">&#39;files&#39;</span><span class="p">]:</span></td>
      </tr>
      <tr>
        <td id="L364" class="blob-line-num js-line-number" data-line-number="364"></td>
        <td id="LC364" class="blob-line-code js-file-line">            <span class="bp">self</span><span class="o">.</span><span class="n">__unique_build_file</span><span class="p">(</span><span class="n">build_phase_hex</span><span class="p">,</span> <span class="n">build_file_hex</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L365" class="blob-line-num js-line-number" data-line-number="365"></td>
        <td id="LC365" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L366" class="blob-line-num js-line-number" data-line-number="366"></td>
        <td id="LC366" class="blob-line-code js-file-line">    <span class="k">def</span> <span class="nf">__unique_group_or_ref</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">parent_hex</span><span class="p">,</span> <span class="n">group_ref_hex</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L367" class="blob-line-num js-line-number" data-line-number="367"></td>
        <td id="LC367" class="blob-line-code js-file-line">        <span class="sd">&#39;&#39;&#39;PBXFileReference PBXGroup PBXVariantGroup PBXReferenceProxy&#39;&#39;&#39;</span></td>
      </tr>
      <tr>
        <td id="L368" class="blob-line-num js-line-number" data-line-number="368"></td>
        <td id="LC368" class="blob-line-code js-file-line">        <span class="n">current_hex</span> <span class="o">=</span> <span class="n">group_ref_hex</span></td>
      </tr>
      <tr>
        <td id="L369" class="blob-line-num js-line-number" data-line-number="369"></td>
        <td id="LC369" class="blob-line-code js-file-line">        <span class="k">if</span> <span class="bp">self</span><span class="o">.</span><span class="n">nodes</span><span class="p">[</span><span class="n">current_hex</span><span class="p">]</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="s">&#39;name&#39;</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L370" class="blob-line-num js-line-number" data-line-number="370"></td>
        <td id="LC370" class="blob-line-code js-file-line">            <span class="n">cur_path_key</span> <span class="o">=</span> <span class="s">&#39;name&#39;</span></td>
      </tr>
      <tr>
        <td id="L371" class="blob-line-num js-line-number" data-line-number="371"></td>
        <td id="LC371" class="blob-line-code js-file-line">        <span class="k">elif</span> <span class="bp">self</span><span class="o">.</span><span class="n">nodes</span><span class="p">[</span><span class="n">current_hex</span><span class="p">]</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="s">&#39;path&#39;</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L372" class="blob-line-num js-line-number" data-line-number="372"></td>
        <td id="LC372" class="blob-line-code js-file-line">            <span class="n">cur_path_key</span> <span class="o">=</span> <span class="s">&#39;path&#39;</span></td>
      </tr>
      <tr>
        <td id="L373" class="blob-line-num js-line-number" data-line-number="373"></td>
        <td id="LC373" class="blob-line-code js-file-line">        <span class="k">else</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L374" class="blob-line-num js-line-number" data-line-number="374"></td>
        <td id="LC374" class="blob-line-code js-file-line">            <span class="c"># root PBXGroup has neither path nor name, give a new name &#39;PBXRootGroup&#39;</span></td>
      </tr>
      <tr>
        <td id="L375" class="blob-line-num js-line-number" data-line-number="375"></td>
        <td id="LC375" class="blob-line-code js-file-line">            <span class="n">cur_path_key</span> <span class="o">=</span> <span class="s">&#39;PBXRootGroup&#39;</span></td>
      </tr>
      <tr>
        <td id="L376" class="blob-line-num js-line-number" data-line-number="376"></td>
        <td id="LC376" class="blob-line-code js-file-line">        <span class="bp">self</span><span class="o">.</span><span class="n">__set_to_result</span><span class="p">(</span><span class="n">parent_hex</span><span class="p">,</span> <span class="n">current_hex</span><span class="p">,</span> <span class="n">cur_path_key</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L377" class="blob-line-num js-line-number" data-line-number="377"></td>
        <td id="LC377" class="blob-line-code js-file-line">        <span class="k">if</span> <span class="bp">self</span><span class="o">.</span><span class="n">nodes</span><span class="p">[</span><span class="n">current_hex</span><span class="p">]</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="s">&#39;children&#39;</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L378" class="blob-line-num js-line-number" data-line-number="378"></td>
        <td id="LC378" class="blob-line-code js-file-line">            <span class="k">for</span> <span class="n">child_hex</span> <span class="ow">in</span> <span class="bp">self</span><span class="o">.</span><span class="n">nodes</span><span class="p">[</span><span class="n">current_hex</span><span class="p">][</span><span class="s">&#39;children&#39;</span><span class="p">]:</span></td>
      </tr>
      <tr>
        <td id="L379" class="blob-line-num js-line-number" data-line-number="379"></td>
        <td id="LC379" class="blob-line-code js-file-line">                <span class="bp">self</span><span class="o">.</span><span class="n">__unique_group_or_ref</span><span class="p">(</span><span class="n">current_hex</span><span class="p">,</span> <span class="n">child_hex</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L380" class="blob-line-num js-line-number" data-line-number="380"></td>
        <td id="LC380" class="blob-line-code js-file-line">        <span class="k">elif</span> <span class="bp">self</span><span class="o">.</span><span class="n">nodes</span><span class="p">[</span><span class="n">current_hex</span><span class="p">][</span><span class="s">&#39;isa&#39;</span><span class="p">]</span> <span class="o">==</span> <span class="s">&#39;PBXReferenceProxy&#39;</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L381" class="blob-line-num js-line-number" data-line-number="381"></td>
        <td id="LC381" class="blob-line-code js-file-line">            <span class="bp">self</span><span class="o">.</span><span class="n">__unique_container_item_proxy</span><span class="p">(</span><span class="n">parent_hex</span><span class="p">,</span> <span class="bp">self</span><span class="o">.</span><span class="n">nodes</span><span class="p">[</span><span class="n">current_hex</span><span class="p">][</span><span class="s">&#39;remoteRef&#39;</span><span class="p">])</span></td>
      </tr>
      <tr>
        <td id="L382" class="blob-line-num js-line-number" data-line-number="382"></td>
        <td id="LC382" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L383" class="blob-line-num js-line-number" data-line-number="383"></td>
        <td id="LC383" class="blob-line-code js-file-line">    <span class="k">def</span> <span class="nf">__unique_build_file</span><span class="p">(</span><span class="bp">self</span><span class="p">,</span> <span class="n">parent_hex</span><span class="p">,</span> <span class="n">build_file_hex</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L384" class="blob-line-num js-line-number" data-line-number="384"></td>
        <td id="LC384" class="blob-line-code js-file-line">        <span class="sd">&#39;&#39;&#39;PBXBuildFile&#39;&#39;&#39;</span></td>
      </tr>
      <tr>
        <td id="L385" class="blob-line-num js-line-number" data-line-number="385"></td>
        <td id="LC385" class="blob-line-code js-file-line">        <span class="n">current_node</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">nodes</span><span class="p">[</span><span class="n">build_file_hex</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L386" class="blob-line-num js-line-number" data-line-number="386"></td>
        <td id="LC386" class="blob-line-code js-file-line">        <span class="n">file_ref_hex</span> <span class="o">=</span> <span class="n">current_node</span><span class="p">[</span><span class="s">&#39;fileRef&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L387" class="blob-line-num js-line-number" data-line-number="387"></td>
        <td id="LC387" class="blob-line-code js-file-line">        <span class="k">if</span> <span class="bp">self</span><span class="o">.</span><span class="n">__result</span><span class="o">.</span><span class="n">get</span><span class="p">(</span><span class="n">file_ref_hex</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L388" class="blob-line-num js-line-number" data-line-number="388"></td>
        <td id="LC388" class="blob-line-code js-file-line">            <span class="n">cur_path_key</span> <span class="o">=</span> <span class="bp">self</span><span class="o">.</span><span class="n">__result</span><span class="p">[</span><span class="n">file_ref_hex</span><span class="p">][</span><span class="s">&#39;path&#39;</span><span class="p">]</span></td>
      </tr>
      <tr>
        <td id="L389" class="blob-line-num js-line-number" data-line-number="389"></td>
        <td id="LC389" class="blob-line-code js-file-line">            <span class="bp">self</span><span class="o">.</span><span class="n">__set_to_result</span><span class="p">(</span><span class="n">parent_hex</span><span class="p">,</span> <span class="n">build_file_hex</span><span class="p">,</span> <span class="n">cur_path_key</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L390" class="blob-line-num js-line-number" data-line-number="390"></td>
        <td id="LC390" class="blob-line-code js-file-line">        <span class="k">else</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L391" class="blob-line-num js-line-number" data-line-number="391"></td>
        <td id="LC391" class="blob-line-code js-file-line">            <span class="bp">self</span><span class="o">.</span><span class="n">__result</span><span class="o">.</span><span class="n">setdefault</span><span class="p">(</span><span class="s">&#39;to_be_removed&#39;</span><span class="p">,</span> <span class="p">[])</span><span class="o">.</span><span class="n">extend</span><span class="p">((</span><span class="n">build_file_hex</span><span class="p">,</span> <span class="n">file_ref_hex</span><span class="p">))</span></td>
      </tr>
      <tr>
        <td id="L392" class="blob-line-num js-line-number" data-line-number="392"></td>
        <td id="LC392" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L393" class="blob-line-num js-line-number" data-line-number="393"></td>
        <td id="LC393" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L394" class="blob-line-num js-line-number" data-line-number="394"></td>
        <td id="LC394" class="blob-line-code js-file-line"><span class="k">def</span> <span class="nf">main</span><span class="p">(</span><span class="n">sys_args</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L395" class="blob-line-num js-line-number" data-line-number="395"></td>
        <td id="LC395" class="blob-line-code js-file-line">    <span class="n">usage</span> <span class="o">=</span> <span class="s">&quot;usage: %prog [-v|-verbose][-u|--unique][-s|--sort] path/to/Project.xcodeproj&quot;</span></td>
      </tr>
      <tr>
        <td id="L396" class="blob-line-num js-line-number" data-line-number="396"></td>
        <td id="LC396" class="blob-line-code js-file-line">    <span class="n">description</span> <span class="o">=</span> <span class="s">&quot;By default, without any option, xUnique uniquify and sort the project file.&quot;</span></td>
      </tr>
      <tr>
        <td id="L397" class="blob-line-num js-line-number" data-line-number="397"></td>
        <td id="LC397" class="blob-line-code js-file-line">    <span class="n">parser</span> <span class="o">=</span> <span class="n">OptionParser</span><span class="p">(</span><span class="n">usage</span><span class="o">=</span><span class="n">usage</span><span class="p">,</span> <span class="n">description</span><span class="o">=</span><span class="n">description</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L398" class="blob-line-num js-line-number" data-line-number="398"></td>
        <td id="LC398" class="blob-line-code js-file-line">    <span class="n">parser</span><span class="o">.</span><span class="n">add_option</span><span class="p">(</span><span class="s">&quot;-v&quot;</span><span class="p">,</span> <span class="s">&quot;--verbose&quot;</span><span class="p">,</span></td>
      </tr>
      <tr>
        <td id="L399" class="blob-line-num js-line-number" data-line-number="399"></td>
        <td id="LC399" class="blob-line-code js-file-line">                      <span class="n">action</span><span class="o">=</span><span class="s">&quot;store_true&quot;</span><span class="p">,</span> <span class="n">dest</span><span class="o">=</span><span class="s">&quot;verbose&quot;</span><span class="p">,</span> <span class="n">default</span><span class="o">=</span><span class="bp">False</span><span class="p">,</span></td>
      </tr>
      <tr>
        <td id="L400" class="blob-line-num js-line-number" data-line-number="400"></td>
        <td id="LC400" class="blob-line-code js-file-line">                      <span class="n">help</span><span class="o">=</span><span class="s">&quot;output verbose messages. default is False.&quot;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L401" class="blob-line-num js-line-number" data-line-number="401"></td>
        <td id="LC401" class="blob-line-code js-file-line">    <span class="n">parser</span><span class="o">.</span><span class="n">add_option</span><span class="p">(</span><span class="s">&quot;-u&quot;</span><span class="p">,</span> <span class="s">&quot;--unique&quot;</span><span class="p">,</span> <span class="n">action</span><span class="o">=</span><span class="s">&quot;store_true&quot;</span><span class="p">,</span> <span class="n">dest</span><span class="o">=</span><span class="s">&quot;unique_bool&quot;</span><span class="p">,</span> <span class="n">default</span><span class="o">=</span><span class="bp">False</span><span class="p">,</span></td>
      </tr>
      <tr>
        <td id="L402" class="blob-line-num js-line-number" data-line-number="402"></td>
        <td id="LC402" class="blob-line-code js-file-line">                      <span class="n">help</span><span class="o">=</span><span class="s">&quot;uniquify the project file. default is False.&quot;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L403" class="blob-line-num js-line-number" data-line-number="403"></td>
        <td id="LC403" class="blob-line-code js-file-line">    <span class="n">parser</span><span class="o">.</span><span class="n">add_option</span><span class="p">(</span><span class="s">&quot;-s&quot;</span><span class="p">,</span> <span class="s">&quot;--sort&quot;</span><span class="p">,</span> <span class="n">action</span><span class="o">=</span><span class="s">&quot;store_true&quot;</span><span class="p">,</span> <span class="n">dest</span><span class="o">=</span><span class="s">&quot;sort_bool&quot;</span><span class="p">,</span> <span class="n">default</span><span class="o">=</span><span class="bp">False</span><span class="p">,</span></td>
      </tr>
      <tr>
        <td id="L404" class="blob-line-num js-line-number" data-line-number="404"></td>
        <td id="LC404" class="blob-line-code js-file-line">                      <span class="n">help</span><span class="o">=</span><span class="s">&quot;sort the project file. default is False.&quot;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L405" class="blob-line-num js-line-number" data-line-number="405"></td>
        <td id="LC405" class="blob-line-code js-file-line">    <span class="p">(</span><span class="n">options</span><span class="p">,</span> <span class="n">args</span><span class="p">)</span> <span class="o">=</span> <span class="n">parser</span><span class="o">.</span><span class="n">parse_args</span><span class="p">(</span><span class="n">sys_args</span><span class="p">[</span><span class="mi">1</span><span class="p">:])</span></td>
      </tr>
      <tr>
        <td id="L406" class="blob-line-num js-line-number" data-line-number="406"></td>
        <td id="LC406" class="blob-line-code js-file-line">    <span class="k">if</span> <span class="nb">len</span><span class="p">(</span><span class="n">args</span><span class="p">)</span> <span class="o">&lt;</span> <span class="mi">1</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L407" class="blob-line-num js-line-number" data-line-number="407"></td>
        <td id="LC407" class="blob-line-code js-file-line">        <span class="n">parser</span><span class="o">.</span><span class="n">print_help</span><span class="p">()</span></td>
      </tr>
      <tr>
        <td id="L408" class="blob-line-num js-line-number" data-line-number="408"></td>
        <td id="LC408" class="blob-line-code js-file-line">        <span class="k">raise</span> <span class="ne">SystemExit</span><span class="p">(</span><span class="s">&quot;xUnique requires at least one positional argument: relative/absolute path to xcodeproj.&quot;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L409" class="blob-line-num js-line-number" data-line-number="409"></td>
        <td id="LC409" class="blob-line-code js-file-line">    <span class="n">xcode_proj_path</span> <span class="o">=</span> <span class="n">args</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span><span class="o">.</span><span class="n">decode</span><span class="p">(</span><span class="n">sys_get_fs_encoding</span><span class="p">())</span></td>
      </tr>
      <tr>
        <td id="L410" class="blob-line-num js-line-number" data-line-number="410"></td>
        <td id="LC410" class="blob-line-code js-file-line">    <span class="n">xunique</span> <span class="o">=</span> <span class="n">XUnique</span><span class="p">(</span><span class="n">xcode_proj_path</span><span class="p">,</span> <span class="n">options</span><span class="o">.</span><span class="n">verbose</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L411" class="blob-line-num js-line-number" data-line-number="411"></td>
        <td id="LC411" class="blob-line-code js-file-line">    <span class="k">if</span> <span class="ow">not</span> <span class="p">(</span><span class="n">options</span><span class="o">.</span><span class="n">unique_bool</span> <span class="ow">or</span> <span class="n">options</span><span class="o">.</span><span class="n">sort_bool</span><span class="p">):</span></td>
      </tr>
      <tr>
        <td id="L412" class="blob-line-num js-line-number" data-line-number="412"></td>
        <td id="LC412" class="blob-line-code js-file-line">        <span class="k">print</span><span class="p">(</span><span class="s">&quot;Uniquify and Sort&quot;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L413" class="blob-line-num js-line-number" data-line-number="413"></td>
        <td id="LC413" class="blob-line-code js-file-line">        <span class="n">xunique</span><span class="o">.</span><span class="n">unique_pbxproj</span><span class="p">()</span></td>
      </tr>
      <tr>
        <td id="L414" class="blob-line-num js-line-number" data-line-number="414"></td>
        <td id="LC414" class="blob-line-code js-file-line">        <span class="k">print</span><span class="p">(</span><span class="s">&quot;Uniquify and Sort done&quot;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L415" class="blob-line-num js-line-number" data-line-number="415"></td>
        <td id="LC415" class="blob-line-code js-file-line">    <span class="k">else</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L416" class="blob-line-num js-line-number" data-line-number="416"></td>
        <td id="LC416" class="blob-line-code js-file-line">        <span class="k">if</span> <span class="n">options</span><span class="o">.</span><span class="n">unique_bool</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L417" class="blob-line-num js-line-number" data-line-number="417"></td>
        <td id="LC417" class="blob-line-code js-file-line">            <span class="k">print</span><span class="p">(</span><span class="s">&#39;Uniquify...&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L418" class="blob-line-num js-line-number" data-line-number="418"></td>
        <td id="LC418" class="blob-line-code js-file-line">            <span class="n">xunique</span><span class="o">.</span><span class="n">unique_project</span><span class="p">()</span></td>
      </tr>
      <tr>
        <td id="L419" class="blob-line-num js-line-number" data-line-number="419"></td>
        <td id="LC419" class="blob-line-code js-file-line">        <span class="k">if</span> <span class="n">options</span><span class="o">.</span><span class="n">sort_bool</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L420" class="blob-line-num js-line-number" data-line-number="420"></td>
        <td id="LC420" class="blob-line-code js-file-line">            <span class="k">print</span><span class="p">(</span><span class="s">&#39;Sort...&#39;</span><span class="p">)</span></td>
      </tr>
      <tr>
        <td id="L421" class="blob-line-num js-line-number" data-line-number="421"></td>
        <td id="LC421" class="blob-line-code js-file-line">            <span class="n">xunique</span><span class="o">.</span><span class="n">sort_pbxproj</span><span class="p">()</span></td>
      </tr>
      <tr>
        <td id="L422" class="blob-line-num js-line-number" data-line-number="422"></td>
        <td id="LC422" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L423" class="blob-line-num js-line-number" data-line-number="423"></td>
        <td id="LC423" class="blob-line-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L424" class="blob-line-num js-line-number" data-line-number="424"></td>
        <td id="LC424" class="blob-line-code js-file-line"><span class="k">if</span> <span class="n">__name__</span> <span class="o">==</span> <span class="s">&#39;__main__&#39;</span><span class="p">:</span></td>
      </tr>
      <tr>
        <td id="L425" class="blob-line-num js-line-number" data-line-number="425"></td>
        <td id="LC425" class="blob-line-code js-file-line">    <span class="n">main</span><span class="p">(</span><span class="n">sys_argv</span><span class="p">)</span></td>
      </tr>
</table>

  </div>

  </div>
</div>

<a href="#jump-to-line" rel="facebox[.linejump]" data-hotkey="l" style="display:none">Jump to Line</a>
<div id="jump-to-line" style="display:none">
  <form accept-charset="UTF-8" class="js-jump-to-line-form">
    <input class="linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" autofocus>
    <button type="submit" class="button">Go</button>
  </form>
</div>

        </div>

      </div><!-- /.repo-container -->
      <div class="modal-backdrop"></div>
    </div><!-- /.container -->
  </div><!-- /.site -->


    </div><!-- /.wrapper -->

      <div class="container">
  <div class="site-footer">
    <ul class="site-footer-links right">
      <li><a href="https://status.github.com/">Status</a></li>
      <li><a href="http://developer.github.com">API</a></li>
      <li><a href="http://training.github.com">Training</a></li>
      <li><a href="http://shop.github.com">Shop</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="/about">About</a></li>

    </ul>

    <a href="/" aria-label="Homepage">
      <span class="mega-octicon octicon-mark-github" title="GitHub"></span>
    </a>

    <ul class="site-footer-links">
      <li>&copy; 2014 <span title="0.07755s from github-fe121-cp1-prd.iad.github.net">GitHub</span>, Inc.</li>
        <li><a href="/site/terms">Terms</a></li>
        <li><a href="/site/privacy">Privacy</a></li>
        <li><a href="/security">Security</a></li>
        <li><a href="/contact">Contact</a></li>
    </ul>
  </div><!-- /.site-footer -->
</div><!-- /.container -->


    <div class="fullscreen-overlay js-fullscreen-overlay" id="fullscreen_overlay">
  <div class="fullscreen-container js-suggester-container">
    <div class="textarea-wrap">
      <textarea name="fullscreen-contents" id="fullscreen-contents" class="fullscreen-contents js-fullscreen-contents js-suggester-field" placeholder=""></textarea>
    </div>
  </div>
  <div class="fullscreen-sidebar">
    <a href="#" class="exit-fullscreen js-exit-fullscreen tooltipped tooltipped-w" aria-label="Exit Zen Mode">
      <span class="mega-octicon octicon-screen-normal"></span>
    </a>
    <a href="#" class="theme-switcher js-theme-switcher tooltipped tooltipped-w"
      aria-label="Switch themes">
      <span class="octicon octicon-color-mode"></span>
    </a>
  </div>
</div>



    <div id="ajax-error-message" class="flash flash-error">
      <span class="octicon octicon-alert"></span>
      <a href="#" class="octicon octicon-x close js-ajax-error-dismiss" aria-label="Dismiss error"></a>
      Something went wrong with that request. Please try again.
    </div>


      <script crossorigin="anonymous" src="https://assets-cdn.github.com/assets/frameworks-12d5fda141e78e513749dddbc56445fe172cbd9a.js" type="text/javascript"></script>
      <script async="async" crossorigin="anonymous" src="https://assets-cdn.github.com/assets/github-766b0d418ce5caf7cf8540ce1c80165442c2ab6b.js" type="text/javascript"></script>
      
      
        <script async src="https://www.google-analytics.com/analytics.js"></script>
  </body>
</html>

