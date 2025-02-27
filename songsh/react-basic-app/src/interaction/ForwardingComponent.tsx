import React, { useState } from 'react'

// 자식 컴포넌트로 상태 전달:
// - 속성을 통해 부모 요소의 상태를 자식 요소로 전달할 수 있음

export default function ForwardingComponent() {

  const [state1, setState1] = useState<number>(0);

  const onChangeHandler = () => {
    setState1(state1 + 1);
  };

  return (
    <div style={{ margin: '40px', padding: '40px', border: '1px solid gray'}}>
      <B state1={state1} />
      <C state1={state1} onChange={onChangeHandler} />
    </div>
  )
}

interface BProp {
  state1: number;
}

function B({ state1 }: BProp) {
  
  return (
    <div style={{ margin: '40px', padding: '40px', border: '1px solid gray'}}>
      <h1>{state1}</h1>
    </div>
  )

}

interface CProp {
  state1: number;
  onChange: () => void;
}

function C(prop: CProp) {
  return (
    <div style={{ margin: '40px', padding: '40px', border: '1px solid gray'}}>
      <D {...prop} />
      <E />
    </div>
  )
}

interface DProp {
  state1: number;
  onChange: () => void;
}

function D({ state1, onChange }: DProp) {

  return (
    <div style={{ margin: '40px', padding: '40px', border: '1px solid gray'}}>
      <h1>{state1}</h1>
      <button onClick={onChange}>증가</button>
    </div>
  )
}

function E() {
  return (
    <div style={{ margin: '40px', padding: '40px', border: '1px solid gray'}}>
      <h1>E 컴포넌트</h1>
    </div>
  )
}