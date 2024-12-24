use elections;

select * from dbo.constituencywise_details;		-- Constituency_ID
select * from dbo.constituencywise_results;		-- Constituency_ID, Party_ID
select * from dbo.statewise_results;			-- State_ID
select * from states;							-- State_ID
select * from partywise_results;				-- Party_ID


-- 1. Total Seats

select count(distinct Constituency_ID) as Total_Seats
from dbo.constituencywise_results;


-- 2. What is the total no of seats available for elections in each state

select s.State, count(distinct cr.Constituency_ID) as Total_seats_available
from constituencywise_results cr
join statewise_results sr
on cr. Parliament_Constituency = sr.Parliament_Constituency
join states s
on sr.State_ID = s.State_ID
group by s.State
order by s.state

-- 3. Total Seats won by NDA Allianz

SELECT 
    SUM(CASE 
            WHEN party IN (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
) then [Won]
else 0 end) as NDA_Allianz_Won
from partywise_results;

-- 4. Seats won by NDA_Alliance Parties


select party as Party_name,
		won as Seats_Won
from partywise_results
where
 party in (                
				'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
)
order by won desc



select Constituency_ID, count(Constituency_ID) as con
from constituencywise_details
group by Constituency_ID
having COUNT(Constituency_ID) > 1;

-- 5. Total seats won by INDIA Allianz

SELECT 
    SUM(CASE 
            WHEN party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'

) then [Won]
else 0 end) as INDIA_Allianz_Won
from partywise_results;


-- 6. Seats won by INDIA Allianz Parties

select party as Party_name,
		won as Total_seats
from partywise_results
where party in (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'

)
order by Total_seats desc;

-- 7. Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER

alter table partywise_results
add party_allianz varchar(50);

update partywise_results
set party_allianz = 'NDA Allianz'
where Party in (                
				'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
);

Update partywise_results
set party_allianz = 'INDIA Allianz'
where party in (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
);

update partywise_results
set party_allianz = 'Other'
where party_allianz is null;

select Party_ID, party, party_allianz
from partywise_results;


select * from statewise_results;

-- 8. Which party alliance (NDA, INDIA, and Other) won the most seats across all states

select party_allianz, sum(Won) as Total_seats_won
from partywise_results
group by party_allianz
order by Total_seats_won desc;

-- 9. Winning Candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency

select cr.Winning_Candidate, p.Party, cr.Total_Votes, cr.Margin, cr.Constituency_Name, s.State
from constituencywise_results cr
join partywise_results p
on cr.Party_ID = p.Party_ID
join statewise_results sr
on cr.Parliament_Constituency = sr.Parliament_Constituency
join states s
on sr.State_ID = s.State_ID
where s.State = 'Odisha' and cr.Constituency_Name = 'Bhubaneswar' 

-- 10. What is the distribution of EVM votes versus postal votes for candidates in a specific constituency

select  cd.Candidate,
		cd.Party,
		cd.EVM_Votes,
		cd.Postal_Votes,
		cd.Total_Votes,
		cr.Constituency_Name,
		s.State
from constituencywise_details cd
join constituencywise_results cr
on cd.Constituency_ID = cr.Constituency_ID
join statewise_results sr
on cr.Parliament_Constituency = sr.Parliament_Constituency
join states s
on sr.State_ID = s.State_ID
where cr.Constituency_Name = 'Bhubaneswar' and s.state = 'Odisha'
order by cd.Total_Votes desc;

-- 11.  Which parties won the most seats in a specific state , and how many seats did each party win?

select  pr.Party,
		count(cr.Constituency_ID) as Seats_won
from partywise_results pr
join constituencywise_results cr
on pr.Party_ID = cr.Party_ID
join statewise_results sr
on cr.Parliament_Constituency = sr.Parliament_Constituency
join states s
on sr.State_ID = s.State_ID
where s.State = 'Telangana'
group by pr.Party
order by Seats_won desc;

-- 12. What is the total no of seats won by each party alliance (NDA, INDIA, Other) in each state for the India Elections 2024

select  s.State,
		SUM(case when pr.party_allianz = 'NDA Allianz' then 1 else 0 end) as NDA_Alliance_Seats,
		SUM(case when pr.party_allianz = 'INDIA Allianz' then 1 else 0 end) as INDIA_Alliance_Seats,
		SUM(case when pr.party_allianz = 'Others' then 1 else 0 end) as Others
from partywise_results pr
join constituencywise_results cr
on cr.Party_ID = pr.Party_ID
join statewise_results sr
on cr.Parliament_Constituency = sr.Parliament_Constituency
join states s
on sr.State_ID = s.State_ID
group by s.State
order by s.State

-- 13. Which candidate received the highest number of EVM votes in each constituency? 

select top 10 cr.Constituency_Name, cr.Constituency_ID, cd.Candidate, cd.EVM_Votes
from constituencywise_details cd
join constituencywise_results cr 
on cd.Constituency_ID = cr.Constituency_ID
where cd.EVM_Votes = (
		select max(cdd.EVM_Votes)
		from constituencywise_details cdd
		where cd.Constituency_ID = cdd.Constituency_ID
)
order by cd.EVM_Votes desc;

-- Tried using window functions (error)
with cte1 as (
select *, ROW_NUMBER() over (partition by cr.Constituency_Name order by cd.evm_votes desc) as rnk
from constituencywise_details cd
join constituencywise_results cr
on cd.Constituency_ID = cr.Constituency_ID
)

select cr.Constituency_Name, cd.Constituency_ID, cd.Candidate, cd.EVM_Votes
from cte1
where rnk = 1

--------------------------------------------------------------------------------

select * from dbo.constituencywise_details;		-- Constituency_ID
select * from dbo.constituencywise_results;		-- Constituency_ID, Party_ID
select * from dbo.statewise_results;			-- State_ID
select * from states;							-- State_ID
select * from partywise_results;				-- Party_ID

----------------------------------------------------------------------------------

select  Candidate,
		Total_Votes,
		(Total_Votes*100.0/sum(Total_Votes) over()) as percentofvotes
from constituencywise_details
where Party = 'Bharatiya Janata Party'

-- 14. Which candidate won and which candidate was the runner-up in each constituency of the state for the 2024 elections?

WITH RankedCandidates as (
select  cd.Constituency_ID,
		cd.Candidate,
		cd.Party,
		cd.EVM_Votes,
		cd.Postal_Votes,
		(cd.EVM_Votes + cd.Postal_Votes) as Total_votes,
		ROW_NUMBER() over (partition by cd.constituency_id order by cd.total_votes desc) as Rnk 
from constituencywise_details cd
join constituencywise_results cr on cd.Constituency_ID = cr.Constituency_ID
join partywise_results pr on cr.Party_ID = pr.Party_ID
join statewise_results sr on cr.Parliament_Constituency = sr.Parliament_Constituency
join states s on s.State_ID = sr.State_ID
where s.State = 'Odisha'
)
select cr.Constituency_Name,
		max(case when rc.Rnk = 1 then rc.Candidate end) as Candidate_Won,			-- max function is used to return one candidate's name from each constituency
		max(case when rc.Rnk = 2 then rc.Candidate end) as Runners_up				-- i.e. if rnk of both candidates are same, only max or one candidate's name is returned.
from RankedCandidates rc
join constituencywise_results cr
on rc.Constituency_ID = cr.Constituency_ID
group by cr.Constituency_Name
order by cr.Constituency_Name



/* 15. For the state of Maharashtra, what are the total number of seats, total number of candidates, total number of parties, total votes (including EVM and postal), 
and the breakdown of EVM and postal votes? */

select  count(distinct cr.Constituency_ID) as Total_Seats,
		count(distinct cd.Candidate) as Total_Candidates,
		count(distinct cd.Party) as Total_Parties,
		sum(cd.EVM_Votes) as Total_EVM_Votes,
		sum(cd.Postal_Votes) as Total_Postal_Votes,
		sum(cd.Total_Votes) as Total_Votes
from constituencywise_details cd
join constituencywise_results cr
on cd.Constituency_ID = cr.Constituency_ID
join statewise_results sr
on sr.Parliament_Constituency = cr.Parliament_Constituency
join states s
on s.State_ID = sr.State_ID
where s.State = 'Maharashtra'


---------------------------------------------------------***----------------------------------------------------------------------