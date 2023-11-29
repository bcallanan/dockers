# dockers
my docker set ups

Hi there, this is my docker repo. They all work except mysql - sorry the volumes used for data, etc. are just a major problem
with regard to docker/windows/virtualbox. I was recently notified or updated that docker is coming out with newer updates with some
type of 'watcher' functionality for volume use. When I get the compose perfect I'll remove this commentary and explain further why
mySql seems a bit more touchy over postgres. Cause the postgres docker just plain works! I have two dockers there that have schema
and data which will give you a really good database to start from.

The pgsecdb database is used in conjuction with the springrestsecury repo i have also share publicly. I have also branched a solid
functional example you can start with: 'functionalPostgresAuthenticationWithSpring'

If you want to try you had there I can help if you get stuck. Just ask!

Oh, and by the way the ethereum docker works too! I have or will expose that repo which will work with that docker-compose. I did that
project cause a Fidelity Investment opportunity had the job desc covering it. So at first I did a crash-course in ethereum blockchain. 
Got it working, built a blockchain microservice that had hooks into the docker set up. Then, FI didnt even ask a single question on it.
Instead, they asked maxOccurence Element in a list of integers or strings whaever the case. 

here's the magic on that one... Though I really wanted the job they went with someone else. I had wished they asked about blockchain and
what I had accomplished. But at least I learned a lot about myself and the technology. No harm / no foul. My appologies for my disappointment
there.

	/*
	 * Problem Stateament
	 *
	 * Given an array nums of size n, return the majority element.
	 *
	 * The majority element is the element that appears more than ⌊n / 2⌋ times. 
	 * You may assume that the majority element always exists in the array
	 * and is always more than half of the values in the array.
	 *
	 * ex) Input: nums = [2,2,1,3,1,2,2]
	 * Output: 2
	 */
	 
   	   System.out.println( "Wont Find dups " );
	     intArray.stream()//( 47,78,78,78,78,78 , 1, 6, 3, 6, 90, 52, 78, 47, 47, 47, 47, 47)
	       .collect( Collectors.groupingBy( Function.identity(), Collectors.counting() ) )
	       .entrySet()
	       .stream()
	       .max( Map.Entry.comparingByValue())
	       .ifPresent( System.out::println );

	     System.out.println( "Will Find dups " );
	     List<T> result =
	    		 intArray.stream()
	    		 .collect(Collectors.groupingBy(Function.identity(), Collectors.counting()))
	    		 .entrySet()
	    		 .stream()
	    		 .collect(Collectors.groupingBy(Map.Entry::getValue,
	    				 Collectors.mapping(Map.Entry::getKey, Collectors.toList())))
	    		 .entrySet()
	    		 .stream().max((o1, o2) -> o1.getKey().compareTo(o2.getKey())).map(Map.Entry::getValue)
	    		 .orElse(Collections.emptyList());


