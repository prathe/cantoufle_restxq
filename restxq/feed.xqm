module namespace page = 'http://basex.org/modules/web-page';
declare namespace atom = "http://www.w3.org/2005/Atom";

declare %restxq:path("harvest")
        %restxq:GET
        %output:omit-xml-declaration("no")
        %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
        %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
        updating function page:harvest() {

  let $url := "http://quebec.pretnumerique.ca/catalog.atom"
  return (db:output(page:redirect("/index")), 
     db:create("feed", $url, "feed.xml"))
};

declare %restxq:path("feed")
        %restxq:GET
        %output:method("xhtml")
        %output:omit-xml-declaration("yes")
        function page:feed() {

  let $feed := fetch:xml("http://quebec.pretnumerique.ca/catalog.atom")
  for $entry in $feed//atom:entry
  let $book := <li>{ $entry/atom:title/text() }</li>
  return $book
};

declare %restxq:path("test")
        %restxq:GET
        %output:method("xhtml")
        %output:omit-xml-declaration("no")
        %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
        %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
        function page:test() {

  let $db := db:open("feed")
  return count($db/atom:feed/atom:entry)
};

(:~
 : Creates a RESTXQ (HTTP) redirect header for the specified link.
 :
 : For more details see: http://docs.basex.org/wiki/RESTXQ#Response
 :
 : @param $redirect  page to forward to
 : @RETURN           redirect header
 :)
declare function page:redirect($redirect as xs:string) as element(restxq:redirect)
{
  <restxq:redirect>{ $redirect }</restxq:redirect>
  
  (:~
   : Internally translates to:
   :
   : <restxq:response>
   :   <http:response status="302" message="Temporary Redirect">
   :     <http:header name="location" value="{ $redirect }"/>
   :   </http:response>
   : </restxq:response>
   :)
};