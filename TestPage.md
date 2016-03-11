# Experimentation with Wiki Syntax #

The question is should we convert text from wiki markup to slides, or from HTML to slides.

To experiment, let's look at a very simple wiki markup (this is the sample Wiki text given in Google Code).

```
#summary One-sentence summary of this page.

= Introduction =

Add your content here.


= Details =

Add your content here.  Format your content with:
  * Text in *bold* or _italic_
  * Headings, paragraphs, and lists
  * Automatic links to other wiki pages
```

Here's the HTML output (after running through tidy -i) from Google Code:

```
  <h1><a name="Introduction">Introduction</h1>

  <p>Add your content here.</p>

  <h1><a name="Details">Details</h1>

  <p>Add your content here. Format your content with:</p>

  <ul>
    <li>Text in <strong>bold</strong> or <i>italic</i></li>

    <li>Headings, paragraphs, and lists</li>

    <li>Automatic links to other wiki pages</li>
  </ul>

```

Looks Ok; however, if we try pasting the same wiki markup into TikiWiki, the markup is not recognized:

```
  <div class="wikitext">
    <ol>
      <li>summary One-sentence summary of this page.</li>
    </ol><br>
    = Introduction =<br>
    <br>
    Add your content here.<br>
    <br>
    <br>
    = Details =<br>
    <br>
    Add your content here. Format your content with:<br>
    * Text in *bold* or _italic_<br>
    * Headings, paragraphs, and lists<br>
    * Automatic links to other wiki pages<br>
  </div>

```

If we convert the source markup into TikiWiki's syntax, here's how it looks:

```
#summary One-sentence summary of this page.

! Introduction 

Add your content here.


! Details 

Add your content here.  Format your content with:
* Text in __bold__ or ''italic''
* Headings, paragraphs, and lists
* Automatic links to other wiki pages
```

Now pasting this markup into TikiWiki, we get the following HTML output (again cleaned up a bit with tidy -i).

```
  <div class="wikitext">
    <ol>
      <li>summary One-sentence summary of this page.</li>
    </ol><br>

    <h2 class="showhide_heading" id="_Introduction">
    Introduction</h2><br>
    Add your content here.<br>
    <br>
    <br>

    <h2 class="showhide_heading" id="_Details">Details</h2><br>
    Add your content here. Format your content with:<br>

    <ul>
      <li>Text in <b>bold</b> or <i>italic</i></li>

      <li>Headings, paragraphs, and lists</li>

      <li>Automatic links to other wiki pages</li>
    </ul>
  </div>
```

## Comments ##
The problem is the diversity of wiki syntax, but there is also a diversity of output from wiki pages.

To Do:
  1. Create an account on the TalentFirst Wiki and Wikipedia
  1. Look at slides 1-7, 18, 30 (nine pages all together) from Tony's presentation http://www.talentfirstnetwork.org/wiki/images/7/73/Ecosystem_approach_to_commercialization_March_28v10.pdf

Using these nine pages as a baseline:
  1. encode them into TikiWiki Format (you can create a sample page on Talent First Network wiki)
  1. encode them into Google Code Wiki
  1. encode them into MediaWiki (use wikipedia)

Once you've encoded them:
  1. Compare the output HTML from each of the wiki engines
  1. Comment on your approach to parsing the HTML output.


# Links #

  * TikiWiki syntax: http://tikiwiki.org/tiki-index.php?page=RFCWiki
  * Wikipedia markup: http://en.wikipedia.org/wiki/Wikipedia:Cheatsheet
  * HTML2Wiki converter: http://search.cpan.org/~diberri/HTML-WikiConverter-0.68/lib/HTML/WikiConverter.pm
  * HTML tidy: http://tidy.sourceforge.net/