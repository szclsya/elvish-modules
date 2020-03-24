fn empty { put [] }

fn length [list]{ count $list }

fn is-empty [list]{
  == 0 (length $list)
}
  
fn first [list]{
  if (is-empty $list) {
	empty
  } else {
	put $list[0]
  }
}

fn rest [list]{
  if (>= 1 (length $list)) {
	empty
  } else {
	put $list[1:]
  }
}

fn last [list]{
  if (is-empty $list) {
	empty
  } else {
	put $list[-1]
  }
}

fn cons [first second]{
  if (is-empty $second) {
	put [$first]
  } else {
	put [$first $@second]
  }
}

fn append [e @rest]{
  if (is-empty $rest) {
	put [(explode $e)]
  } else {
	put [(explode $e) (explode (append (explode $rest)))]
  }
}

fn reverse [list]{
  if (is-empty $list) {
	empty
  } else {
	append (reverse (rest $list)) (cons (first $list) (empty))
  }
}

fn filter [list is-valid]{
  if (is-empty $list) {
	empty
  } elif ($is-valid (first $list)) {
	cons (first $list) (filter (rest $list) $is-valid)
  } else {
	filter (rest $list) $is-valid
  }
}

fn foldr [f base l]{
  if (is-empty $l) {
	put $base
  } else {
	$f (first $l) (foldr $f $base (rest $l))
  }
}

fn foldl [f base l]{
  foldr $f $base (reverse $l)
}

map = [operation list]{
  each $operation $list
}

sort = [list is-less-than]{
  # Quick sort at the beginning here.
  partition = [list piviot is-less-than]{
	put (filter $list [x]{ $is-less-than $x $piviot })
  }

  if (is-empty (rest $list)) {
	put $list
  } else {
	piviot=(first $list)
	first-half=($partition $list (first $list) $is-less-than)
	second-half=($partition $list (first $list) [x y]{not ($is-less-than $x $y)})

	append $first-half $second-half
  }
}
