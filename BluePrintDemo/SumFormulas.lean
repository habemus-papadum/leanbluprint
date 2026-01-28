import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Tactic

namespace BluePrintDemo

/-- The sum of the first n natural numbers equals n*(n+1)/2 -/
theorem sum_naturals (n : ℕ) :
    ∑ i ∈ Finset.range (n + 1), i = n * (n + 1) / 2 := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ, ih]
    omega

/-- The sum of the first n squares equals n*(n+1)*(2n+1)/6 -/
theorem sum_squares (n : ℕ) :
    ∑ i ∈ Finset.range (n + 1), i ^ 2 = n * (n + 1) * (2 * n + 1) / 6 := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ, ih]
    ring_nf
    omega

end BluePrintDemo
