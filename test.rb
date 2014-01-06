person1 = {first: "Chris", last: "Mitchell"}
person2 = {first: "Aurora", last: "Mitchell"}
person3 = {first: "Mark", last: "Mitchell"}

params = {
	father: person1,
	mother: person2,
	child: person3
}

puts "This is params :father :first::: #{params[:father][:first]}"