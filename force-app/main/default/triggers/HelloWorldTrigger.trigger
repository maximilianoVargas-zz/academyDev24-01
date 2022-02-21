trigger HelloWorldTrigger on Account (before insert) {
    System.debug('Hello World!');
}