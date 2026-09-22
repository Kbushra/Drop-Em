with other
{
	if hp == 0 { exit; }
	
	_score -= other.score_penalty;
	if _score < 0 { _score = 0; }
	hp = 0;
}