import React from 'react'

// Properties (속성)
// - 부모 컴포넌트(호출부)에서 자식 컴포넌트로 데이터를 전달하기 위한 *객체*
// - 부모 컴포넌트에서는 HTML과 동일한 방식으로(속성=값) 전달
// - 자식 컴포넌트에서는 함수의 매개변수로 속성을 받음
// - 전달할 수 있는 데이터는 변수에 담을 수 있는 모든 데이터 형식

// - 컴포넌트가 리렌더링되는 기준
// - 속성은 부모 -> 자식으로 데이터 전송 0 / 자식 -> 부모로 데이터 전송 X
interface Props {
  title: string;
  subTitle: string;
  contents: string;
}

function Article(props: Props) {

  return (
    <article style={{ border: '1px solid gray', marginBottom: '8px' }}>
      <h1>{props.title}</h1>
      <h3>{props.subTitle}</h3>
      <p>{props.contents}</p>
    </article>
  )
}

export default function Properties() {
  return (
    <div>
      <Article />
      <Article />
      <Article />
    </div>
  )
}

