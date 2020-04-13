# JMS Serializer

## Groupes de sérialization

Utiliser des `SerializationContext` à injecter dans `serialize()` :
`$serializer->serialize(new BlogPost(), 'json', SerializationContext::create()->setGroups(array('list')));`

https://jmsyst.com/libs/serializer/master/cookbook/exclusion_strategies#creating-different-views-of-your-objects