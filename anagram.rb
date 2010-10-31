class Array
  def deleted(index)
    sd=self.dup
    sd.delete_at(index)
    sd
  end

  def sum
    self.inject(0){|r,e|r+e}
  end

  def mult
    self.inject(1){|r,e|r*e}
  end

  def permutation(num=self.length)
    return map{|e|[e]} if num == 1
    self.inject_with_index([]){|ret, e, i|
      ret+= self.deleted(i).permutation(num-1).map{|a|a.unshift(e)}}
  end


end


class Range
  def gen(stp=1, &blk)
    ret=[];    self.step(stp){|i|ret.push(if blk; blk.call(i);else;i;end)};ret
  end
end


class String
  def anagram(wordlist=nil)
    if wordlist
      @@wtb={};(97..122).gen{|i|h={};(97..122).gen{|ii|h[ii.chr.intern]=0};@@wtb[i.chr.intern]=h}
      wordlist.each{|w|0.upto(w.length-2){|i|k, v=w[i, 2].split("").map{|c|c.intern}; begin @@wtb[k][v]+=1;rescue;end}}
      @@wtb.each{|k, v|oc=v.to_a.transpose[1].sum.to_f; v.each{|c, o|v[c]=o/oc}}
    end
    self.split("").permutation.map{|word|
      [(0..(word.length-2)).gen{|i|k, v=word[i..i+1].map{|s|s.intern};@@wtb[k][v]}.mult,
	word]
    }.sort.reverse.transpose[1].map{|l|l.join}
  end
end
