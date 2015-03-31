module namespace page = 'http://basex.org/modules/web-page';

declare %restxq:path("index")
        %output:method("xhtml")
        %output:omit-xml-declaration("no")
        %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
        %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
        function page:index() {

  let $result := if (db:exists("feed")) then
    let $db := db:open("my-blog")
    let $books := for $entry in $db/feed/entry
    let $book := <li>{ $entry/title/text() }</li>
    return <ul>{ $book }</ul>
  else
    <p>feed DB does not exist</p>

  return <html>
    <body>
      { $result }
    </body>
  </html>
};