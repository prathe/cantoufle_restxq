module namespace page = 'http://basex.org/modules/web-page';

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

declare %restxq:path("index")
        %restxq:GET
        %output:method("xhtml")
        %output:omit-xml-declaration("no")
        %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
        %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
        function page:index() {

    let $db := db:open("feed")
    let $books := for $entry in $db/feed/entry
      return <li>{ $entry/title/text() }</li>
    return <ul>{ $books }</ul>
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